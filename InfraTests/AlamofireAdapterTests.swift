//
//  AlamofireAdapterTests.swift
//  InfraTests
//
//  Created by Macbook on 13/09/21.
//

import XCTest
import Alamofire
import Data

class AlamofireAdapter {
    private let session: Session
    
    init(session: Session = .default) {
        self.session = session
    }
    func post(to url: URL, with data: Data?, completion: @escaping (Result<Data, HttpError>) -> Void) {
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).responseData { dataResponse in
            guard dataResponse.response?.statusCode != nil else { return
                completion(.failure(.noConnectivity)) }
            switch dataResponse.result {
            case .failure: completion(.failure(.noConnectivity))
            case .success(let data):
                completion(.success(data))
            }
        }
    }
}

class AlamofireAdapterTests: XCTestCase {
    func test_post_should_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        testRequestFor(url: url, data: makeValidData()) { request in
            XCTAssertEqual(url, request.url) // valida se esse url é mesma informada fora
            XCTAssertEqual("POST", request.httpMethod) // valida o metodo
            XCTAssertNotNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_make_request_with_request_with_no_data() {
        testRequestFor(data: nil) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_post_should_complete_with_error_when_request_completes_with_error() {
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases() {
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError())) //ok ok ok
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError())) // ok x ok
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil)) // ok x x
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: makeError())) //x ok ok
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil)) //x ok x
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil)) // x x x
    }
}


extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #file, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session) //quando executa uma requisição com esse session que foi passado no Almofire, vai cair no UrlProtocolStub
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.post(to: url, with: data) { _ in exp.fulfill()}
        var request: URLRequest?
        UrlProtocolStub.ObserverRequest { request = $0 } // o observerRequest esta observando o UrlProtocolStub e quando estiver pronto vai me retornar um request
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectedResult(_ expectedResult: Result<Data, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.post(to: makeUrl(), with: makeValidData()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData),.success(let receivedData)): XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

//generico para qualquer ferramenta que for usada para fazer request (por exemplo a UrlSession)
class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static var data: Data?
    static var response: HTTPURLResponse?
    static var error: Error?
    
    static func ObserverRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
    }
    
    static func simulate(data: Data?, response: HTTPURLResponse?, error: Error?) {
        UrlProtocolStub.data = data
        UrlProtocolStub.response = response
        UrlProtocolStub.error = error
    }
    // usou override pois esta reescrevendo classe e sobreescrevendo os metodos dela
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override open func startLoading() {
        UrlProtocolStub.emit?(request)
        if let data = UrlProtocolStub.data {
            client?.urlProtocol(self, didLoad: data)
        }
        if let response = UrlProtocolStub.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }
        if let error = UrlProtocolStub.error {
            client?.urlProtocol(self, didFailWithError: error)
        }
        client?.urlProtocolDidFinishLoading(self) // ao terminar dispara o request
    }
    
    override open func stopLoading() {
        
    }
}


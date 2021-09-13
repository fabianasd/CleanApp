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
    func post(to url: URL, with data: Data?) {
        session.request(url, method: .post, parameters: data?.toJson(), encoding: JSONEncoding.default).resume()
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
}

extension AlamofireAdapterTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> AlamofireAdapter {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = Session(configuration: configuration)
        let sut = AlamofireAdapter(session: session) //quando executa uma requisição com esse session que foi passado no Almofire, vai cair no UrlProtocolStub
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), data: Data?, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        sut.post(to: url, with: data)
        let exp = expectation(description: "waiting")
        UrlProtocolStub.ObserverRequest { request in // o observerRequest esta observando o UrlProtocolStub e quando estiver pronto vai me retornar um request
            action(request)
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}

//generico para qualquer ferramenta que for usada para fazer request (por exemplo a UrlSession)
class UrlProtocolStub: URLProtocol {
    static var emit: ((URLRequest) -> Void)?
    static func ObserverRequest(completion: @escaping (URLRequest) -> Void) {
        UrlProtocolStub.emit = completion
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
    }
    
    override open func stopLoading() {
        
    }
}



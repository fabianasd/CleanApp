//
//  AlamofireAdapterTests.swift
//  InfraTests
//
//  Created by Macbook on 13/09/21.
//

import XCTest
import Alamofire
import Data
import Infra

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
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError())) // x x ok
    }
    
    func test_post_should_complete_with_error_on_all_invalid_cases() {
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(), error: makeError())) //ok ok ok
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: makeError())) // ok x ok
        expectedResult(.failure(.noConnectivity), when: (data: makeValidData(), response: nil, error: nil)) // ok x x
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: makeError())) //x ok ok
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: makeHttpResponse(), error: nil)) //x ok x
        expectedResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: nil)) // x x x
    }
    
    func test_post_should_complete_with_data_when_request_completes_with_200() {
        expectedResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil)) // ok ok nil
    }
    
    func test_post_should_complete_with_no_data_when_request_completes_with_204() {
        expectedResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil)) // nil ok nil
        expectedResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil)) // ok ok nil
        expectedResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil)) // ok ok nil
    }
    
    
    func test_post_should_complete_with_data_when_request_completes_with_non_200() {
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil)) // ok ok nil
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil)) // ok ok nil
        expectedResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil)) // ok ok nil
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil)) // ok ok nil
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil)) // ok ok nil
        expectedResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil)) // ok ok nil
        expectedResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil)) // ok ok nil
        expectedResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil)) // ok ok nil
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
    
    func expectedResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #file, line: UInt = #line) {
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

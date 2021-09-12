//
//  RemoteAddAccountTests.swift
//  RemoteAddAccountTests
//
//  Created by Macbook on 07/09/21.
//

import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(addAccountModel: makeAddAccountModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAddAccountModel()
        sut.add(addAccountModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_complet_with_error_if_client_completes_with_error() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completionWith: .failure(.unexpected), when: { //espero que o sut complete com um erro do tipo .unexpected quando...
            httpClientSpy.completionWithError(.noConnectivity) //... o postClient completar com um erro
        })
    }
    
    func test_add_should_complet_with_account_if_client_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let account = makeAccountModel()
        expect(sut, completionWith: .success(account), when: { //espero que o sut complete com um success do tipo account quando...
            httpClientSpy.completionWithData(account.toData()!) //... o postClient completar com um toData do tipo account validos
        })
    }
    
    func test_add_should_complet_with_error_if_client_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completionWith: .failure(.unexpected), when: { //espero que o sut complete com um erro do tipo .unexpected quando...
            httpClientSpy.completionWithData(makeInvalidData()) //completar com dados invalidos
        })
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpClientSpy()
        var sut: RemoteAddAccount? = RemoteAddAccount(url: makeUrl(), httpClient: httpClientSpy)
        var result: Result<AccountModel, DomainError>?
        sut?.add(addAccountModel: makeAddAccountModel()) { result = $0 }
        sut = nil
        httpClientSpy.completionWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAddAccountTests {
    //factory
    func makeSut(url: URL = URL(string: "http://any-url.com")!, file: StaticString = #file, line: UInt = #line) -> (sut: RemoteAddAccount, HttpClientSpy: HttpClientSpy) {
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAddAccount, completionWith expectedResult: Result<AccountModel, DomainError>, when action: () -> Void, file: StaticString = #file, line: UInt = #line) { // file e line: permite visualizar o erro exatamente na linha que ocorre
        let exp = expectation(description: "waiting") // a execução é assincrona, com essa config. ele acessa e executa o XTCAssertEqual
        sut.add(addAccountModel: makeAddAccountModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) received \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill() //config
        }
        action()
        wait(for: [exp], timeout: 1) //config
    }
    
    func makeAddAccountModel() -> AddAccountModel {
        return AddAccountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
    }
}

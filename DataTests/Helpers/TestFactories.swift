//
//  TestFactories.swift
//  DataTests
//
//  Created by Macbook on 12/09/21.
//

import Foundation

func makeInvalidData() -> Data {
    return Data("invalid_data".utf8)
}

func makeEmptyData() -> Data {
    return Data()
}

func makeValidData() -> Data {
    return Data("{\"name\":\"Fabiana\"}".utf8)
}

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

func makeError() -> Error {
    return NSError(domain: "any_error", code: 0)
}

func makeHttpResponse(statusCode: Int = 200) -> HTTPURLResponse {
    return HTTPURLResponse(url: makeUrl(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
}

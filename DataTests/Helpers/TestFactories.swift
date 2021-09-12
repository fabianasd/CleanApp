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

func makeUrl() -> URL {
    return URL(string: "http://any-url.com")!
}

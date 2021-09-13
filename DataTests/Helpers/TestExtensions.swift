//
//  TestExtensions.swift
//  DataTests
//
//  Created by Macbook on 12/09/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func checkMemoryLeak(for instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in //executa no final do testes e verificar a memory leak
            XCTAssertNil(instance, file: file, line: line)
        }
    }
    
}

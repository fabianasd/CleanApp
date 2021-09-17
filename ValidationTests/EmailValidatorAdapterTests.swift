//
//  ValidationTests.swift
//  ValidationTests
//
//  Created by Macbook on 17/09/21.
//

import XCTest

public final class EmailValidatorAdapter {
    private let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}

class EmailValidatorAdapterTests: XCTestCase {
    func test_invalid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertFalse(sut.isValid(email: "rr"))
        XCTAssertFalse(sut.isValid(email: "rr@"))
        XCTAssertFalse(sut.isValid(email: "rr@rr"))
        XCTAssertFalse(sut.isValid(email: "rr@rr."))
        XCTAssertFalse(sut.isValid(email: "@rr.com"))
    }
    
    func test_valid_emails() {
        let sut = EmailValidatorAdapter()
        XCTAssertTrue(sut.isValid(email: "any@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "any@hotmail.com"))
        XCTAssertTrue(sut.isValid(email: "any@hotmail.com.br"))
    }
}
//
//  SignUpViewControllerTests.swift
//  UITests
//
//  Created by Macbook on 16/09/21.
//

import XCTest
import UIKit
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        let sb = UIStoryboard(name: "Sign", bundle: Bundle(for: SignUpViewController.self))
        let sut = sb.instantiateViewController(identifier: "loadingIndicator") as! SignUpViewController
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.loadingIndicator?.isAnimating, false)
    }
}

//
//  WelcomeRouterTests.swift
//  UITests
//
//  Created by Macbook on 21/09/21.
//

import XCTest
import UIKit
import UI

class WelcomeRouterTests: XCTestCase {
    public final class WelcomeRouter {
        private let nav: NavigationController
        private let loginFactory: () -> LoginViewController
        
        public init(nav: NavigationController, loginFactory: @escaping () -> LoginViewController) {
            self.nav = nav
            self.loginFactory = loginFactory
        }
        
        public func gotoLogin() {
            nav.pushViewController(loginFactory())
        }
    }
    
    func test_gotoLogin_calls_nav_with_correct_vc() {
        let loginFactorySpy = LoginFactorySpy()
        let (sut, nav) = makeSut()
        sut.gotoLogin()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is LoginViewController)
    }
    
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }
}

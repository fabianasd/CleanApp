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
}

extension WelcomeRouterTests {
    func makeSut() -> (sut: WelcomeRouter, nav: NavigationController) {
        let loginFactorySpy = LoginFactorySpy()
        let signUpFactorySpy = SignUpFactorySpy()
        let nav = NavigationController()
        let sut = WelcomeRouter(nav: nav, loginFactory: loginFactorySpy.makeLogin, signUpFactory: signUpFactorySpy.makeSignUp)
        return (sut, nav)
    }
}

extension WelcomeRouterTests {
    class LoginFactorySpy {
        func makeLogin() -> LoginViewController {
            return LoginViewController.instantiate()
        }
    }

    class SignUpFactorySpy {
        func makeSignUp() -> SignUpViewController {
            return SignUpViewController.instantiate()
        }
    }
}

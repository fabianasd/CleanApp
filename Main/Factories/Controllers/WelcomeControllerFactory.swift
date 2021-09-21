//
//  LoginControllerFactory.swift
//  Main
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import UI

public func makeWelcomeController(nav: NavigationController) -> WelcomeViewController {
    let router = WelcomeRouter(nav: nav, loginFactory: makeLoginController, signUpFactory: makeSignUpController)
    let controller = WelcomeViewController.instantiate()
    controller.signUp = router.gotoSign
    controller.login = router.gotoLogin
    return controller
}


//
//  SignUpComposer.swift
//  Main
//
//  Created by Macbook on 17/09/21.
//

import Foundation
import UI
import Presentation
import Validation
import Domain

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> (SignUpViewController) {
        let controller = SignUpViewController.instantiate()
        let presenter = SignUpPresenter(alertView: WeakVarProxy(controller), addAccount: addAccount, loadingView: WeakVarProxy(controller))
        controller.signUp = presenter.signUp
        return controller
    }
}

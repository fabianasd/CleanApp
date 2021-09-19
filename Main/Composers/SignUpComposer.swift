//
//  SignUpComposer.swift
//  Main
//
//  Created by Macbook on 17/09/21.
//

import Foundation
import Domain
import UI

public final class SignUpComposer {
    public static func composeControllerWith(addAccount: AddAccount) -> (SignUpViewController) {
        return ControllerFactory.makeSignUp(addAccount: addAccount)
    }
}

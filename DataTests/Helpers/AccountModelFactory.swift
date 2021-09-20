//
//  AccountModelFactory.swift
//  DataTests
//
//  Created by Macbook on 12/09/21.
//

import Foundation
import Domain

func makeAccountModel() -> AccountModel {
    return AccountModel(accessToken: "any_token")
}

func makeAddAccountModel() -> AddAccountModel {
    return AddAccountModel(name: "any_name", email: "any_email@mail.com", password: "any_password", passwordConfirmation: "any_password")
}


func makeAuthenticationModel() -> AuthenticationModel {
    return AuthenticationModel(email: "any_email@mail.com", password: "any_password")
}

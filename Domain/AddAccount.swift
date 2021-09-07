//
//  AddAccount.swift
//  Domain
//
//  Created by Macbook on 07/09/21.
//

import Foundation

//vai receber alguns dados do cadastro, e no final retorna uma conta criada
public protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

public struct AddAccountModel: Encodable {
    public var name: String
    public var email: String
    public var password: String
    public var passwordConfirmation: String
    
    public init(name:String, email: String, password: String, passwordConfirmation: String) {
        self.name = name
        self.email = email
        self.password = password
        self.passwordConfirmation = passwordConfirmation
    }
}

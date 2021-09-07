//
//  AddAccount.swift
//  Domain
//
//  Created by Macbook on 07/09/21.
//

import Foundation

//vai receber alguns dados do cadastro, e no final retorna uma conta criada
protocol AddAccount {
    func add(addAccountModel: AddAccountModel, completion: @escaping (Result<AccountModel, Error>) -> Void)
}

struct AddAccountModel {
    var name: String
    var email: String
    var password: String
    var passwordConfirmation: String
}

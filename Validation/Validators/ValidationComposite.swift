//
//  ValidationComposite.swift
//  Validation
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import Presentation

//Composite: recebe um array com varios validators, pega todos os validators e faz um loop, chama o validate de cada um, se algum falhar interrompe a execução e retorna o erro. Se nenhum falhar retorna nil

public final class ValidationComposite: Validation {
    let validations: [Validation]
    
    public init(validations: [Validation]) {
        self.validations = validations
    }
    
    public func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}

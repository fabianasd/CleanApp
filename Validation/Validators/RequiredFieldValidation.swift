//
//  RequiredFieldValidation.swift
//  Validation
//
//  Created by Macbook on 19/09/21.
//

import Foundation
import Presentation

public final class RequiredFieldValidation: Validation {
    private let fieldName: String
    private let fieldLabel: String
    
    public init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else { //pega o valor que esta dentro do dicionario data, dentro da propriedade fieldName, se o data for nulo, se o campo fieldName não existir, se não for convertido para string retorna erro...Se o campo existir e não for vazio retorna nil, senão retorna a mensagem
            return "O campo \(fieldLabel) é obrigatório"
        }
        return nil
    }
}

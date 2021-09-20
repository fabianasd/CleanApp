//
//  CompareFieldsValidation.swift
//  Validation
//
//  Created by Macbook on 19/09/21.
//

import Foundation
import Presentation

public final class CompareFieldsValidation: Validation {
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    public init(fieldName: String,fieldNameToCompare: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldNameToCompare = fieldNameToCompare
        self.fieldLabel = fieldLabel
    }
    
    public func validate(data: [String : Any]?) -> String? {
        //converteu fieldName para string, verifica tambem o fieldNameToCompare existe, se não existir ou forem diferentes, retorna "O campo...",
        guard let fieldName = data?[fieldName] as? String, let fieldNameToCompare = data?[fieldNameToCompare] as? String, fieldName == fieldNameToCompare else {
            return "O campo \(fieldLabel) é inválido"
        }
        return nil
    }
}

//
//  EmailValidator.swift
//  Presentation
//
//  Created by Macbook on 14/09/21.
//

import Foundation

public protocol EmailValidator {
    func isValid(email: String) -> Bool
}

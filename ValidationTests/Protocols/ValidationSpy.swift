//
//  ValidationSpy.swift
//  ValidationTests
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import Presentation

class ValidationSpy: Validation {
    var errorMessage: String?
    
    func validate(data: [String : Any]?) -> String? {
        return errorMessage
    }
    
    func simulateError(_ errorMessage: String) {
        self.errorMessage = errorMessage
    }
}

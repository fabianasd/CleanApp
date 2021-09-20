//
//  Validation.swift
//  Presentation
//
//  Created by Macbook on 19/09/21.
//

import Foundation

public protocol Validation {
    func validate(data: [String: Any]?) -> String?
}

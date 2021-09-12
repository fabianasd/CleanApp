//
//  ExtensionHelpers.swift
//  Data
//
//  Created by Macbook on 11/09/21.
//

import Foundation

public extension Data {
    func toModel<T: Decodable>() -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}

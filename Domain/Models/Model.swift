//
//  Model.swift
//  Domain
//
//  Created by Macbook on 07/09/21.
//

import Foundation

public protocol Model: Codable, Equatable {}

public extension Model {
    func toData() ->  Data? {
        return try? JSONEncoder().encode(self)
    }
}

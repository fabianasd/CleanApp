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
    
    //transforma data para dicionario
    func toJson() ->  [String: Any]? {
        guard let data = self.toData() else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
    }
}

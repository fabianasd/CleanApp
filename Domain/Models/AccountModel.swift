//
//  AccountModel.swift
//  Domain
//
//  Created by Macbook on 07/09/21.
//

import Foundation

public struct AccountModel: Model {
    public var accessToken: String
    
    public init(accessToken: String) {
        self.accessToken = accessToken
    }
}

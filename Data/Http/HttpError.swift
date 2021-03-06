//
//  HttpError.swift
//  Data
//
//  Created by Macbook on 10/09/21.
//

import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}


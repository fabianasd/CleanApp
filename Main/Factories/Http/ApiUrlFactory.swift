//
//  ApiUrlFactory.swift
//  Main
//
//  Created by Macbook on 17/09/21.
//

import Foundation

func makeApiUrl(path: String) -> URL {
    return URL(string: "\(Environment.variable(.apiBaseUrl))/\(path)")!
}

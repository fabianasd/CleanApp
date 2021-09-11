//
//  HttpPostClient.swift
//  Data
//
//  Created by Macbook on 07/09/21.
//

import Foundation

public protocol HttpPostClient {
    func post(to url: URL, with data: Data?, completion: @escaping (HttpError) -> Void)
}

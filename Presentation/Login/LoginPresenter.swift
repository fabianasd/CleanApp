//
//  LoginPresenter.swift
//  Presentation
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import Domain

public final class LoginPresenter {
    private let validation: Validation
    
    public init(validation: Validation) {
        self.validation = validation
    }
    
    public func login(viewModel: LoginRequest) {
        _ = validation.validate(data: viewModel.toJson())
    }
}

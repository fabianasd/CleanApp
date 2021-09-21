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
    private let alertView: AlertView
    
    public init(validation: Validation, alertView: AlertView, authentication: Authentication, loadingView: LoadingView) {
        self.validation = validation
        self.alertView = alertView
    }
    
    public func login(viewModel: LoginRequest) {
        if let message = validation.validate(data: viewModel.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        }
    }
}

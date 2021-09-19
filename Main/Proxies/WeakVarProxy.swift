//
//  WeakVarProxy.swift
//  Main
//
//  Created by Macbook on 18/09/21.
//

import Foundation
import Presentation

//proxy: colocar uma camada a mais em cima do que se deseja fazer algo
final class WeakVarProxy<T: AnyObject> {
    private weak var instance: T?
    
    init(_ instance: T) {
        self.instance = instance
    }
}

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func display(viewModel: LoadingViewModel) {
        instance?.display(viewModel: viewModel)
    }
}

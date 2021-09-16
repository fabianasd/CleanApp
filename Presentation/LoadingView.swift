//
//  LoadingView.swift
//  Presentation
//
//  Created by Macbook on 14/09/21.
//

import Foundation

public protocol LoadingView {
    func display(viewModel: LoadingViewModel)
}

//Model
public struct LoadingViewModel: Equatable {
    public var isLoading: Bool
    
    public init(isLoading: Bool) {
        self.isLoading = isLoading
    }
}

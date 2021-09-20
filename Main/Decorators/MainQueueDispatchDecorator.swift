//
//  MainQueueDispatchDecorator.swift
//  Main
//
//  Created by Macbook on 19/09/21.
//

import Foundation
import Domain

//Decorator
public final class MainQueueDispatchDecorator<T> {
    private let instance: T
    
    public init(_ instance: T) {
        self.instance = instance
    }
    
    func dispatch(completion: @escaping() -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}

extension MainQueueDispatchDecorator: AddAccount where T: AddAccount {
    public func add(addAccountModel: AddAccountModel, completion: @escaping (AddAccount.Result) -> Void) {
        instance.add(addAccountModel: addAccountModel) { [weak self] result in
            self?.dispatch { completion(result) }
        }
    }
}

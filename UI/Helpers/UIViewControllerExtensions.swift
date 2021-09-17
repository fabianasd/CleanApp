//
//  UIViewControllerExtensions.swift
//  UI
//
//  Created by Macbook on 16/09/21.
//

import Foundation
import UIKit

//config keyboard
extension UIViewController {
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        gesture.cancelsTouchesInView = false
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

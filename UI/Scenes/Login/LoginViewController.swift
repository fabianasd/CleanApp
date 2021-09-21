//
//  LoginViewController.swift
//  UI
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import UIKit
import Presentation

public final class LoginViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        title = "4Dev"
        loginButton?.layer.cornerRadius = 5
        hideKeyboardOnTap()
    }
}

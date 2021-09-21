//
//  WelcomeViewController.swift
//  UI
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import UIKit

public final class WelcomeViewController: UIViewController, Storyboarded {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signButton: UIButton!
    
    public var login: (() -> Void)?
    public var signUp: (() -> Void)?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        title = "4Dev"
        loginButton?.layer.cornerRadius = 5
        loginButton?.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signButton?.layer.cornerRadius = 5
        signButton?.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func loginButtonTapped() {
        login?()
    }
    
    @objc private func signUpButtonTapped() {
        signUp?()
    }
}

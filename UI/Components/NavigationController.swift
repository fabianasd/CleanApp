//
//  NavigationController.swift
//  UI
//
//  Created by Macbook on 20/09/21.
//

import Foundation
import UIKit

//criação da borda em cima 
public final class NavigationController: UINavigationController {
    public override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
//    private var currentViewController: UIViewController?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        setup()
//    }
//
//    public convenience init() {
//        self.init(nibName: nil, bundle: nil)
//    }

    private func setup() {
        navigationBar.barTintColor = Color.primaryDark
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black //inverte as cores das fontes no top do telefone: preto > branco
    }

//    public func setRootViewController(_ viewController: UIViewController) {
//        setViewControllers([viewController], animated: true)
//        currentViewController = viewController
//        hideBackButtonText()
//    }
//
//    public func pushViewController(_ viewController: UIViewController) {
//        pushViewController(viewController, animated: true)
//        currentViewController = viewController
//        hideBackButtonText()
//    }
//
//    public func hideBackButtonText() {
//        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
//    }
}

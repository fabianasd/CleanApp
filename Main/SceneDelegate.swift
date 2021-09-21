//
//  SceneDelegate.swift
//  Main
//
//  Created by Macbook on 17/09/21.
//

import UIKit
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let httpClient = makeAlamofireAdapter()
        let authentication = makeRemoteAuthentication(httpClient: httpClient)
        let signUpController = makeSignUpController(addAccount: addAccount)
        nav.setRootViewController(signUpController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}


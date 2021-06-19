//
//  SceneDelegate.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import UIKit
import Sixsmith

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var viewController: HexagonViewController?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        let viewController = HexagonViewController()
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = viewController
        window.makeKeyAndVisible()
        
        self.window = window
        self.viewController = viewController
    }
}

//
//  SceneDelegate.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: TabCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let coordinator = TabCoordinator()
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()
        
        self.window = window
        self.coordinator = coordinator
        
        coordinator.start()
    }
}

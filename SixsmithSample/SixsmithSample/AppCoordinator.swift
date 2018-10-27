
import UIKit

class AppCoordinator: NSObject, UITabBarControllerDelegate {

    let uiViewController = UIHexagonViewController()
    let skViewController = SKHexagonViewController()

    var rootViewController: UIViewController {
        return tabBarController
    }

    let tabBarController: UITabBarController

    override init() {
        self.tabBarController = UITabBarController()
    }

    func start() {
        uiViewController.tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(named: "UIKitImage"), selectedImage: nil)
        skViewController.tabBarItem = UITabBarItem(title: "SpriteKit", image: UIImage(named: "SpriteKitImage"), selectedImage: nil)

        tabBarController.addChild(uiViewController)
        tabBarController.addChild(skViewController)

        tabBarController.delegate = self
    }
}

//
//  TabCoordinator.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import Sixsmith
import UIKit

class TabCoordinator {
    var rootViewController: UIViewController {
        let tabController = UITabBarController()
        tabController.viewControllers = [
            hexagonViewController,
            sceneCoordinator.rootViewController
        ]
        
        return tabController
    }
    
    let sceneCoordinator: SceneCoordinator
    let hexagonViewController: HexagonViewController
    let hexagonGroup: HexGroup
    
    init() {
        let hexagonViewController = HexagonViewController()
        
        let hexagonGroup = HexGroup(dataSource: hexagonViewController)
        hexagonGroup.drawDelegate = hexagonViewController
        
        let sceneCoordinator = SceneCoordinator(frame: UIScreen.main.bounds)
        
        self.hexagonGroup = hexagonGroup
        self.hexagonViewController = hexagonViewController
        self.sceneCoordinator = sceneCoordinator
    }
    
    func start() {
        hexagonGroup.draw()
        sceneCoordinator.start()
    }
}

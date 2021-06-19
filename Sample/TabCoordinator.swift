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
            hexagonViewController
        ]
        
        return tabController
    }
    
    let hexagonViewController: HexagonViewController
    let hexagonGroup: HexGroup
    
    init() {
        let hexagonViewController = HexagonViewController()
        
        let hexagonGroup = HexGroup(dataSource: hexagonViewController)
        hexagonGroup.drawDelegate = hexagonViewController
        
        self.hexagonGroup = hexagonGroup
        self.hexagonViewController = hexagonViewController
    }
    
    func start() {
        hexagonGroup.draw()
    }
}

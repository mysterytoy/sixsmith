//
//  TabCoordinator.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import Sixsmith
import UIKit
import SwiftUI

class TabCoordinator {
    var rootViewController: UIViewController {
        let tabController = UITabBarController()
        
        tabController.viewControllers = [
            hexagonViewController,
            sceneCoordinator.rootViewController,
            hexagonsViewHost
        ]
        
        return tabController
    }
    
    let hexagonsViewHost: UIHostingController<HexagonsView>
    let sceneCoordinator: SceneCoordinator
    let hexagonViewController: HexagonViewController
    let hexagonGroup: HexGroup
    
    init() {
        let hexagonViewController = HexagonViewController()
        
        let config =  HexGroupConfiguration(
            coordinateSystem: .increaseTowardBottomRight,
            groupOrigin: .init(
                Double(UIScreen.main.bounds.size.width) / 2,
                Double(UIScreen.main.bounds.size.height) / 2
            ),
            groupShape: .hexagon(radius: 4),
            hexagonSize: 25.0,
            hexagonScaleFactor: 0.95,
            hexagonOrientation: .flat
        )
        
        let hexagonGroup = HexGroup(config) { hex, drawData in
            hexagonViewController.dataForHex(hex, drawData: drawData)
        }
                
        let sceneCoordinator = SceneCoordinator(frame: UIScreen.main.bounds)
        
        let hexagonsViewHost = UIHostingController(rootView: HexagonsView())
        hexagonsViewHost.tabBarItem = UITabBarItem(
            title: "SwiftUI",
            image: UIImage(systemName: "swift"),
            tag: 2
        )
        
        self.hexagonGroup = hexagonGroup
        self.hexagonViewController = hexagonViewController
        self.sceneCoordinator = sceneCoordinator
        self.hexagonsViewHost = hexagonsViewHost
    }
    
    func start() {
        sceneCoordinator.start()
    }
}

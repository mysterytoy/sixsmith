
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
    
    var data: [Hex.DrawData] = Array()
    
    let _ = HexGroup(config) { _, drawData in
      data.append(drawData)
    }
    
    let hexagonsViewHost = UIHostingController(
      rootView: HexagonsView(
        data: data
      )
    )
    
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

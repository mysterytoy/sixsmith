//
//  HexagonViewController.swift
//  Sample
//
//  Created by Edward Toy on 19/06/2021.
//

import UIKit
import Sixsmith

class HexagonViewController: UIViewController {
    var hexagonView: DrawingView
    
    init() {
        let hexagonView = DrawingView()
        hexagonView.backgroundColor = .systemBackground
        
        self.hexagonView = hexagonView
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarItem = UITabBarItem(title: "UIKit", image: UIImage(systemName: "suitcase"), tag: 0)
        
        hexagonView.frame = view.frame
        
        view.addSubview(hexagonView)
    }
    
    func dataForHex(_ hex: Hex, drawData: Hex.DrawData) {
        hexagonView.paths.append(drawData.vertices)
    }
}

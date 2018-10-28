
import UIKit
import Sixsmith

class UIHexagonViewController: UIViewController, HexagonGroupDelegate {

    var hexagonView: HexagonView?

    override func viewDidLoad() {
        super.viewDidLoad()

        hexagonView = HexagonView(frame: view.frame)

        let center = CGPoint(x: view.frame.size.width / 2,
                             y: view.frame.size.height / 2)

        let group = HexagonGroup(dataSource: DataSource(origin: center,
                                                        system: .increaseTowardBottomRight),
                                 delegate: self)
        group.present()

        view.addSubview(hexagonView!)
    }

    func dataForHexagon(_ hex: Hex, drawData: DrawData) {
        hexagonView?.paths.append(drawData.vertices)
    }

    func touchAtHexagon(_ hex: Hex) {
        
    }
}

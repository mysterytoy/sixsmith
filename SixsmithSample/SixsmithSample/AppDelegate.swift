
import UIKit
import Sixsmith

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = self.window else { fatalError("Unable to get Window in AppDelegate") }
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()

        return true
    }
}


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var coordinator: AppCoordinator!
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        self.window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = self.window else { fatalError("Unable to get Window in AppDelegate") }

        coordinator = AppCoordinator()

        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()

        coordinator.start()

        return true
    }
}

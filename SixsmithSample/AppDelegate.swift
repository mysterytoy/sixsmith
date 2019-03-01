
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var coordinator: AppCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.coordinator = AppCoordinator()

        guard let window = self.window else { fatalError("Unable to get Window in AppDelegate") }
        guard let coordinator = self.coordinator else { fatalError("Unable to initialise AppCoordinator") }

        window.rootViewController = coordinator.rootViewController
        window.makeKeyAndVisible()

        coordinator.start()

        return true
    }
}

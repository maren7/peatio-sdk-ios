import UIKit
import PeatioSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PeatioSDK.start(host: "beta.big.zone")
        PeatioSDK.debugMode = .all
        return true
    }
}

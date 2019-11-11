import UIKit
import PeatioSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        PeatioSDK.start(host: "b1.run")
        PeatioSDK.debugMode = .disabled
        PeatioSDK.setToken(try! PeatioToken.estimatedDeserialize(jwtToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJjNjU5NzI0YmQxYTY1MjZkZjFmZjhlNjljNzE5MzQ0MyIsImlkIjozNTcxMzcsImJyb2tlcl9pZCI6MSwiaXNfdHJhZGluZ19lbmFibGVkIjoxLCJzdWIiOjM1NzEzNywiaXNzIjoiUGFuYW1lcmEiLCJ0eXBlIjoiQmFzaWMiLCJuYmYiOjE1NzM0NzQxODEsImlhdCI6MTU3MzQ3NDI0MSwiZXhwIjoxNTczNTYwNjQxfQ.jjNbEujpg82FJKdF0ArMeyJB3M-cyEB3ApbzGfz99wo"))
        PeatioSDK.setDeviceID("D927981D-A8D8-498F-97DD-73E005D36293")
        PeatioSDK.setUA("BigONE/1.8.3 (x86_64; iOS 11.4.0) Build/159")

        _ = PeatioSDK.execute(SpotAccountsOperation(param: .init())) { (result) in
            switch result {
            case .failure(let errror):
                print(errror.errorDescription)
            case .success(let data):
                print(data.first(where: { $0.asset.symbol == "BTC"})?.estimatedBtc ?? "null")
            }
        }
        return true
    }
}

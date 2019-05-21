import UIKit

public extension UIFont {
    static func oxygen(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Oxygen-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func boldOxygen(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Oxygen-Bold", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func lightOxygen(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Oxygen-Light", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

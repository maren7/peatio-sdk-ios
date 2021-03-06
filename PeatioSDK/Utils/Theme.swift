import Foundation
import UIKit

public protocol Theme {
    var colors: Colors { get }
    var fonts: Fonts { get }
    var keyboardAppearance: UIKeyboardAppearance { get }
}

private struct _DarkTheme: Theme {
    let fonts: Fonts = _DarkThemeFonts()
    let colors: Colors = _DarkThemeColors()
    let keyboardAppearance: UIKeyboardAppearance = .dark
}

public protocol Colors {

    var pageBackgroundColor: UIColor { get }


    var textWhite: UIColor { get }
    var placeholder: UIColor { get }
    var textBlue: UIColor { get }

    var disableTitle: UIColor { get }
    var disableBackground: UIColor { get }
    var enableBackground: UIColor { get }

    var errorToast: UIColor { get }
    var warnToast: UIColor { get }

    var seperateLine: UIColor { get }

    var segmentLine: UIColor { get }
    var textFieldError: UIColor { get }

    var inputTintColor: UIColor { get }

    var nextStepHint: UIColor { get }

}

private struct _DarkThemeColors: Colors {

    let pageBackgroundColor: UIColor = UIColor(hex: "#0B1013")

    let textWhite: UIColor = .white
    let placeholder = UIColor(hex: "#52616D")
    let textBlue = UIColor(hex: "#5F99DA")

    let disableTitle = UIColor(hex: "#707D8A")
    let disableBackground = UIColor(hex: "#394551")
    let enableBackground = UIColor(hex: "#5F99DA")

    let errorToast = UIColor(hex: "#FF6262")
    let warnToast = UIColor(hex: "#F5A624")

    let seperateLine = UIColor(hex: "#394551")

    let segmentLine = UIColor(hex: "#5F99DA")
    let textFieldError = UIColor(hex: "#FF614C")

    let inputTintColor: UIColor = UIColor(hex: "#5F99DA")

    let nextStepHint: UIColor = UIColor(hex: "#8C99A6")
}

public protocol Fonts {
    var title: UIFont { get }
    var segment: UIFont { get }
    var subtitle: UIFont { get }
    var toast: UIFont { get }

    var barButton: UIFont { get }
    var fullFillButton: UIFont { get }
    var buttonNormal: UIFont { get }
    var buttonLower: UIFont { get }

    var textfield: UIFont { get }
    var textfieldInvalid: UIFont { get }

    var gaInput: UIFont { get }
}

private struct _DarkThemeFonts: Fonts {
    let title = UIFont.oxygen(ofSize: 24)
    let segment = UIFont.oxygen(ofSize: 16)
    let subtitle = UIFont.oxygen(ofSize: 13)
    let toast = UIFont.boldOxygen(ofSize: 14)

    let barButton = UIFont.boldOxygen(ofSize: 12)
    let fullFillButton = UIFont.boldOxygen(ofSize: 14)
    let buttonNormal = UIFont.oxygen(ofSize: 13)
    let buttonLower = UIFont.oxygen(ofSize: 12)

    let textfield = UIFont.oxygen(ofSize: 13)
    let textfieldInvalid = UIFont.oxygen(ofSize: 12)

    let gaInput: UIFont = UIFont.systemFont(ofSize: 20)
}

public class ThemeManager {
    public static let current: Theme = _DarkTheme()
}

import Foundation
import UIKit

public protocol Theme {
    var colors: Colors { get }
    var fonts: Fonts { get }
}

private struct _DarkTheme: Theme {
    let fonts: Fonts = _DarkThemeFonts()
    let colors: Colors = _DarkThemeColors()
}

public protocol Colors {

    // title & subtitle
    var title: UIColor { get }
    var titleBlue: UIColor { get }
    var information: UIColor { get }

    // fullfill button
    var fEnableTitle: UIColor { get }
    var fDisableTitle: UIColor { get }
    var fDisableBackground: UIColor { get }
    var fEnableBackground: UIColor { get }
    var fUnselectedTitle: UIColor { get }
    
    // toast
    var errorToast: UIColor { get }
    var warnToast: UIColor { get }

    // segment
    var segmentIndicator: UIColor { get }
    var segmentSelect: UIColor { get }
    var segmentUnselect: UIColor { get }
    
    // text input
    var seperate: UIColor { get }
    var textInputInvalid: UIColor { get }
    var textInputTitle: UIColor { get }
    var textInputText: UIColor { get }
    var placeholder: UIColor { get }
    
    // normal button
    var enableTitle: UIColor { get }
    var disableTitle: UIColor { get }
    
    // viewcontroller
    var background: UIColor { get }
}

private struct _DarkThemeColors: Colors {
    
    let title: UIColor = .white
    let titleBlue = UIColor(hex: "#5F99DA")
    let information = UIColor(hex: "#8C99A6")

    let fEnableTitle = UIColor(hex: "#5F99DA")
    let fDisableTitle = UIColor(hex: "#707D8A")
    let fDisableBackground = UIColor(hex: "#394551")
    let fEnableBackground = UIColor(hex: "#5F99DA")
    let fUnselectedTitle: UIColor = UIColor(hex: "#8C99A6")

    let errorToast = UIColor(hex: "#FF6262")
    let warnToast = UIColor(hex: "#F5A624")

    let segmentIndicator = UIColor(hex: "#5F99DA")
    let segmentSelect: UIColor = .white
    let segmentUnselect: UIColor = UIColor(hex: "#52616D")
    
    let seperate = UIColor(hex: "#394551")
    let textInputInvalid = UIColor(hex: "#FF614C")
    let textInputTitle = UIColor(hex: "#8C99A6")
    let textInputText: UIColor = .white
    let placeholder = UIColor(hex: "#52616D")
    
    let disableTitle = UIColor(hex: "#52616D")
    let enableTitle = UIColor(hex: "#5F99DA")
    
    let background = UIColor(hex: "#0B1013")
}

public protocol Fonts {
    
    // title & subtitle
    var title: UIFont { get }
    var subtitle: UIFont { get }
    var information: UIFont { get }
    
    // fullfill button
    var fullFillButton: UIFont { get }
    var barButton: UIFont { get }
    var inputButton: UIFont { get }
    var selectButton: UIFont { get }
    var agreementButton: UIFont { get }
    var findPasswordButton: UIFont { get }
    
    // toast
    var toast: UIFont { get }
    
    // segment
    var segment: UIFont { get }
    
    // text input
    var textInput: UIFont { get }
    var textInputInvalid: UIFont { get }
}

private struct _DarkThemeFonts: Fonts {
    
    let title = UIFont.oxygen(ofSize: 24)
    let subtitle = UIFont.oxygen(ofSize: 13)
    let information = UIFont.oxygen(ofSize: 12)
    
    let fullFillButton = UIFont.boldOxygen(ofSize: 14)
    let barButton = UIFont.oxygen(ofSize: 12)
    let inputButton = UIFont.oxygen(ofSize: 13)
    let selectButton = UIFont.oxygen(ofSize: 12)
    let agreementButton = UIFont.oxygen(ofSize: 12)
    let findPasswordButton = UIFont.boldOxygen(ofSize: 12)
    
    let toast = UIFont.boldOxygen(ofSize: 14)
    
    let segment = UIFont.oxygen(ofSize: 16)
    
    let textInput = UIFont.oxygen(ofSize: 13)
    let textInputInvalid = UIFont.oxygen(ofSize: 12)
}

public class ThemeManager {
    public static let current: Theme = _DarkTheme()
}

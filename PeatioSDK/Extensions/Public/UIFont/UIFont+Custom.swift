import UIKit

public extension UIFont {
    static func oxygen(ofSize size: CGFloat) -> UIFont {
        return _loadFont(name: "Oxygen-Regular", size: size)
    }

    static func boldOxygen(ofSize size: CGFloat) -> UIFont {
        return _loadFont(name: "Oxygen-Bold", size: size)
    }

    static func lightOxygen(ofSize size: CGFloat) -> UIFont {
        return _loadFont(name: "Oxygen-Light", size: size)
    }

    private static func _loadFont(name: String, size: CGFloat) -> UIFont {
        var result = self.init(name: name, size: size)

        // To XCTest
        let peatioBundle = Bundle(for: PeatioSDK.self).bundleURL
        if result == nil,
            let contents = try? FileManager.default.contentsOfDirectory(at: peatioBundle, includingPropertiesForKeys: [], options: .skipsHiddenFiles) {
            contents.forEach {
                guard $0.pathExtension == "ttf",
                    let provider = CGDataProvider(url: $0 as CFURL),
                    let font = CGFont(provider) else {
                        return
                }
                CTFontManagerRegisterGraphicsFont(font, nil)
            }
        }

        result = self.init(name: name, size: size)
        if result == nil {
            _dynamicRegister(name: name)
            result = self.init(name: name, size: size)
        }
        guard let font = result else { fatalError("could not load font") }
        return font
    }

    private static func _dynamicRegister(name: String) {
        let mainBundlePath = Bundle.main.bundlePath
        var bundle: Bundle? = Bundle.main

        if Bundle.main.url(forResource: name, withExtension: "ttf") == nil {
            let bundlePath = mainBundlePath + "/Peatio.bundle"
            bundle = Bundle(path: bundlePath)
            if bundle == nil {
                bundle = Bundle(path: mainBundlePath + "/Frameworks/Peatio.framework/Peatio.bundle")
            } 
        }

        guard let fontBundle = bundle else { fatalError("no bundle") }
        guard let fontURL = fontBundle.url(forResource: name, withExtension: "ttf") else { fatalError("no font file") }
        guard let dataProvider = CGDataProvider(url: fontURL as CFURL) else { fatalError("could not load font data") }
        guard let cgFont = CGFont(dataProvider) else { fatalError("could not create font from data") }
        var error: Unmanaged<CFError>?
        let result = CTFontManagerRegisterGraphicsFont(cgFont, &error)
        if !result { fatalError("can not register the font") }
    }
}

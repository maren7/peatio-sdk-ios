import Foundation

struct Log {
    enum Level: String {
        case debug = "DEBUG"
        case error = "ERROR"
    }

    static func debug(
        _ message: @autoclosure () -> Any,
        _ file: String = #file,
        _ function: String = #function,
        _ line: Int = #line) {
        assert({ print("\n☘️ \(Level.debug.rawValue) [\(file) `\(function)` #\(line)]\n\(message())\n"); return true }())
    }

    static func error(
        _ message: @autoclosure () -> Any,
        _ file: String = #file,
        _ function: String = #function,
        _ line: Int = #line) {
        print("❌ \(Level.error.rawValue) [\(file) `\(function)` #\(line)]\n\(message())\n")
    }
}

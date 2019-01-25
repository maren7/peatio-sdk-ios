import Foundation

final class PeatioIdentifier: Hashable, CustomDebugStringConvertible {

    let objectId: ObjectIdentifier
    private let _message: String

    init(_ x: AnyObject) {
        objectId = ObjectIdentifier(x)
        _message = "Object: \(x)"
    }

    init(_ x: Any.Type) {
        objectId = ObjectIdentifier(x)
        _message = "Type: \(x)"
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(objectId)
        hasher.combine(_message)
    }

    var debugDescription: String {
        return "PeatioIdentifier {\n  itemID: \(objectId)\n  message: \(_message)\n}"
    }

    static func == (lhs: PeatioIdentifier, rhs: PeatioIdentifier) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

extension PeatioIdentifier {
    convenience init(_ x: String) {
        self.init(x as NSString)
    }
}

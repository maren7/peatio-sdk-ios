import Foundation

extension String {
    var base64Data: Data? {
        let rem = self.count % 4
        let pending = rem > 0 ? String(repeating: "=", count: 4 - rem) : ""
        let base64 = self.replacingOccurrences(of: "-", with: "+").replacingOccurrences(of: "_", with: "/") + pending
        return Data(base64Encoded: base64)
    }

    init?(base64Data: Data) {
        let data = base64Data.base64EncodedData()
        guard let origin = String(data: data, encoding: .utf8) else { return nil }
        self = origin
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}

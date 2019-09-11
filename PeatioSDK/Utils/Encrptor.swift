import Foundation
import Security

final class Encryptor {

    static let shared = Encryptor()

    private var publicKey: SecKey!

    init() { }

    static func register(pubKeyString: String) {
        let trimmed = pubKeyString
            .replacingOccurrences(of: "-----BEGIN PUBLIC KEY-----\n", with: "")
            .replacingOccurrences(of: "\n-----END PUBLIC KEY-----", with: "")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\t", with: "")
            .replacingOccurrences(of: "\n", with: "")
            .replacingOccurrences(of: " ", with: "")

        guard let data = Data(base64Encoded: trimmed) else {
            fatalError("invalid pubkey")
        }

        let attributes: CFDictionary = [kSecAttrKeyType         : kSecAttrKeyTypeRSA,
                                        kSecAttrKeyClass        : kSecAttrKeyClassPublic,
                                        kSecAttrKeySizeInBits   : 1024,
                                        kSecReturnPersistentRef : kCFBooleanTrue!] as CFDictionary

        var error: Unmanaged<CFError>? = nil
        guard let secKey = SecKeyCreateWithData(data as CFData, attributes, &error) else {
            fatalError("invalid pubkey")
        }

        shared.publicKey = secKey
    }

    static func encrypt(string: String) -> String {
        guard let pub = shared.publicKey else {
            fatalError("register pubkey first")
        }
        let buffer = [UInt8](string.utf8)

        var keySize   = SecKeyGetBlockSize(pub)
        var keyBuffer = [UInt8](repeating: 0, count: keySize)

        guard SecKeyEncrypt(pub, SecPadding.PKCS1, buffer, buffer.count, &keyBuffer, &keySize) == errSecSuccess else {
            fatalError("encrypt faailed")
        }
        return Data(bytes: keyBuffer, count: keySize).base64EncodedString()
    }
}

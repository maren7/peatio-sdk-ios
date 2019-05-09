import Foundation

struct RequestOperationResult<T: Decodable> {
    let code: Int64
    let message: String
    var data: T?
    var decodeDataError: Error?
    let pageToken: String?

    var isSuccessful: Bool {
        return code == 0
    }
}

extension RequestOperationResult: Decodable {

    fileprivate enum CodingKeys: String, CodingKey {
        case code
        case message
        case data
        case pageToken
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try container.decode(Int64.self, forKey: .code)
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        var pageTokenValue = (try? container.decode(Optional<String>.self, forKey: .pageToken)) ?? nil
        if pageTokenValue == "" {
            pageTokenValue = nil
        }
        self.pageToken = pageTokenValue
        if (T.self as? OverlapDecodable.Type) != nil {
            self.data = nil
        } else {
            do {
                self.data = try container.decode(T.self, forKey: .data)
            } catch let error {
                self.data = nil
                self.decodeDataError = error
            }
        }
    }
}

extension RequestOperationResult where T == JustOK {

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let code = try container.decode(Int64.self, forKey: .code)
        self.code = code
        self.message = (try? container.decode(String.self, forKey: .message)) ?? ""
        var pageTokenValue = (try? container.decode(Optional<String>.self, forKey: .pageToken)) ?? nil
        if pageTokenValue == "" {
            pageTokenValue = nil
        }
        self.pageToken = pageTokenValue
        self.data = code == 0 ? JustOK() : nil
    }
}

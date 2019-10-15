import Foundation

protocol PageDecodable: Decodable {
    var nextToken: String? { get set }
}

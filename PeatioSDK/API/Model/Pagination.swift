import Foundation

public struct Pagination: Codable {
    public let currentPage: Int
    public let perPage: Int
    public let totalPages: Int
    public let totalRecords: Int
}

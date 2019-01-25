import Foundation

public enum RequestContentType: String {
    case json = "application/json"
    case formData = "application/x-www-form-urlencoded; charset=utf-8"

    static let headerName = "Content-Type"
}

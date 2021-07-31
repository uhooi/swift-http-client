import Foundation

/// Request contents.
public protocol Request {
    associatedtype ResponseBody: Decodable
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var httpHeaders: [HTTPHeaderField: String]? { get }
}

public extension Request {
    var queryItems: [URLQueryItem]? { nil }
    var httpHeaders: [HTTPHeaderField: String]? { nil }
}

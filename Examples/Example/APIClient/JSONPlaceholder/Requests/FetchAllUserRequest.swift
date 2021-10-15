import HTTPClient

struct FetchAllUserRequest: Request {
    typealias ResponseBody = [User]
    var path: String { "users" }
    var httpMethod: HTTPMethod { .get }
    var httpHeaders: [HTTPHeaderField: String]? { [.contentType: ContentType.applicationJson.rawValue] }
}


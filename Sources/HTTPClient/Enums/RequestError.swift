/// Request error.
public enum RequestError: Error {
    case invalidUrl
    case invalidData
    case invalidResponse
    case redirection(_ statusCode: Int)
    case clientError(_ statusCode: Int)
    case serverError(_ statusCode: Int)
    case invalidStatusCode(_ statusCode: Int)
}

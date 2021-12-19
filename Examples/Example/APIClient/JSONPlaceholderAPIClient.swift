import HTTPClient

final class JSONPlaceholderAPIClient {
    static let shared = JSONPlaceholderAPIClient()
    
    private let httpClient = HTTPClient(baseURLString: "https://jsonplaceholder.typicode.com/")
}

extension JSONPlaceholderAPIClient: JSONPlaceholderRepository {
    // Swift Concurrency
    func fetchAllUser() async throws -> [User] {
        return try await httpClient.request(FetchAllUserRequest())
    }
    
    // Completion handler
    func fetchAllUser(_ completion: @escaping (Result<[User], Error>) -> Void) {
        httpClient.request(FetchAllUserRequest()) { result in
            completion(result)
        }
    }
}


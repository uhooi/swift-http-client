import HTTPClient

final class JSONPlaceholderAPIClient {
    static let shared = JSONPlaceholderAPIClient()
    
    private let httpClient = HTTPClient(baseURLString: "https://jsonplaceholder.typicode.com/")
}

extension JSONPlaceholderAPIClient: JSONPlaceholderRepository {
    func fetchAllUser(_ completion: @escaping (Result<[User], Error>) -> Void) {
        httpClient.request(FetchAllUserRequest()) { result in
            completion(result)
        }
    }
}


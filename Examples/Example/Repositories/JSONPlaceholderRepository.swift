protocol JSONPlaceholderRepository {
    // Swift Concurrency
    func fetchAllUser() async throws -> [User]
    
    // Completion handler
    func fetchAllUser(_ completion: @escaping (Result<[User], Error>) -> Void)
}


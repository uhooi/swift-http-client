protocol JSONPlaceholderRepository {
    func fetchAllUser(_ completion: @escaping (Result<[User], Error>) -> Void)
}


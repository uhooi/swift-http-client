import UIKit

final class ViewController: UIViewController {
    
    // MARK: Stored Instance Properties
    
    private let repository: JSONPlaceholderRepository = JSONPlaceholderAPIClient.shared
    
    private var users: [User] = []
    
    // MARK: View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Swift Concurrency
        Task {
            do {
                self.users = try await repository.fetchAllUser()
                print("Swift Concurrency:", users)
            } catch {
                print("Swift Concurrency:", error)
            }
        }

        // Completion handler
        repository.fetchAllUser { result in
            switch result {
            case let .success(users):
                self.users = users
                print("Completion handler:", users)
            case let .failure(error):
                print("Completion handler:", error)
            }
        }
    }

}


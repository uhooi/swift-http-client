import UIKit

final class ViewController: UIViewController {
    
    // MARK: Stored Instance Properties
    
    private let repository: JSONPlaceholderRepository = JSONPlaceholderAPIClient.shared
    
    private var users: [User] = []
    
    // MARK: View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repository.fetchAllUser { result in
            switch result {
            case let .success(users):
                self.users = users
                print(users)
            case let .failure(error):
                print(error)
            }
        }
    }

}


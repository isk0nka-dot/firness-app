import Foundation
import FirebaseAuth

final class UserRepository {
    
    private let network: NetworkManager
    private let firebase: FirebaseManager
    private let local: CoreDataStack
    
    init(network: NetworkManager, firebase: FirebaseManager, local: CoreDataStack) {
        self.network = network
        self.firebase = firebase
        self.local = local
    }
    
    // MARK: - Authentication
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            } else if let uid = authResult?.user.uid {
                completion(.success(uid))
            }
        }
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func currentUserId() -> String? {
        Auth.auth().currentUser?.uid
    }
}

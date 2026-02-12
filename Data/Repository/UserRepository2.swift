import Foundation

final class UserRepository {
    
    private let firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    // MARK: - User data
    
    func fetchUserFavorites(userId: String, completion: @escaping ([String]) -> Void) {
        firebaseManager.fetchUserData(userId: userId) { data in
            let favorites = data["favorites"] as? [String] ?? []
            completion(favorites)
        }
    }
    
    func addFavorite(exerciseId: String, forUserId userId: String) {
        firebaseManager.updateUserData(userId: userId, key: "favorites", value: exerciseId, add: true)
    }
    
    func removeFavorite(exerciseId: String, forUserId userId: String) {
        firebaseManager.updateUserData(userId: userId, key: "favorites", value: exerciseId, add: false)
    }
    
    func syncProgress(userId: String, progress: [String: Any]) {
        firebaseManager.updateUserData(userId: userId, key: "progress", value: progress)
    }
}

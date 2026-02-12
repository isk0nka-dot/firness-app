import SwiftUI

final class ProfileViewModel: ObservableObject {
    
    @Published var user: User
    
    private let userRepository: UserRepository
    private let syncUserUseCase: SyncUserProgressUseCase
    
    init(user: User,
         userRepository: UserRepository = DIContainer.shared.userRepository,
         syncUserUseCase: SyncUserProgressUseCase = DIContainer.shared.syncUserProgressUseCase) {
        self.user = user
        self.userRepository = userRepository
        self.syncUserUseCase = syncUserUseCase
    }
    
    func loadUserData() {
        guard let userId = userRepository.currentUserId() else { return }
        syncUserUseCase.execute(userId: userId) { [weak self] syncedUser in
            DispatchQueue.main.async {
                self?.user = syncedUser
            }
        }
    }
    
    func signOut() {
        do {
            try userRepository.signOut()
            // Можно добавить navigation back на экран логина
        } catch {
            print("Sign out failed: \(error.localizedDescription)")
        }
    }
}

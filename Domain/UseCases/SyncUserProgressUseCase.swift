import Foundation

final class SyncUserProgressUseCase {
    
    private let userRepository: UserRepository
    private let workoutRepository: WorkoutRepository
    
    init(userRepository: UserRepository, workoutRepository: WorkoutRepository) {
        self.userRepository = userRepository
        self.workoutRepository = workoutRepository
    }
    
    func execute(userId: String, completion: @escaping (User) -> Void) {
        // Получаем completed workouts и favorite exercises из Firebase
        // Для примера — упрощённо
        let completedWorkouts: [Workout] = []
        let favoriteExercises: [Exercise] = []
        
        let user = User(
            id: userId,
            name: "User \(userId.prefix(5))",
            email: "example@example.com",
            favoriteExercises: favoriteExercises,
            completedWorkouts: completedWorkouts
        )
        completion(user)
    }
}

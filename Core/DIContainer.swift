import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    private init() {}
    
    // MARK: - Repositories
    
    private lazy var exerciseRepository: ExerciseRepository = {
        ExerciseRepository(
            network: NetworkManager.shared,
            firebase: FirebaseManager.shared,
            local: CoreDataStack.shared
        )
    }()
    
    private lazy var workoutRepository: WorkoutRepository = {
        WorkoutRepository(
            network: NetworkManager.shared,
            firebase: FirebaseManager.shared,
            local: CoreDataStack.shared
        )
    }()
    
    private lazy var userRepository: UserRepository = {
        UserRepository(
            network: NetworkManager.shared,
            firebase: FirebaseManager.shared,
            local: CoreDataStack.shared
        )
    }()
    
    // MARK: - ViewModels Factory
    
    func makeExerciseListViewModel() -> ExerciseListViewModel {
        return ExerciseListViewModel(repository: exerciseRepository)
    }
    
    func makeExerciseDetailViewModel(exerciseId: String) -> ExerciseDetailViewModel {
        return ExerciseDetailViewModel(
            exerciseId: exerciseId,
            repository: exerciseRepository
        )
    }
    
    func makeWorkoutFormViewModel() -> WorkoutFormViewModel {
        return WorkoutFormViewModel(repository: workoutRepository)
    }
    
    func makeProfileViewModel() -> ProfileViewModel {
        return ProfileViewModel(repository: userRepository)
    }
    
    func makeSearchExerciseViewModel() -> SearchExerciseViewModel {
        return SearchExerciseViewModel(repository: exerciseRepository)
    }
}

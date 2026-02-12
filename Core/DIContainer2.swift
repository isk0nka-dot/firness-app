import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    // MARK: - Repositories
    lazy var exerciseRepository: ExerciseRepository = ExerciseRepository(
        localDataSource: LocalDataSource.shared,
        remoteDataSource: RemoteDataSource.shared,
        firebaseManager: FirebaseManager.shared
    )
    
    lazy var workoutRepository: WorkoutRepository = WorkoutRepository(
        localDataSource: LocalDataSource.shared,
        remoteDataSource: RemoteDataSource.shared
    )
    
    lazy var userRepository: UserRepository = UserRepository(
        firebaseManager: FirebaseManager.shared
    )
    
    // MARK: - Use Cases
    lazy var fetchExercisesUseCase: FetchExercisesUseCase = FetchExercisesUseCase(repository: exerciseRepository)
    lazy var addWorkoutUseCase: AddWorkoutUseCase = AddWorkoutUseCase(repository: workoutRepository)
    lazy var syncUserProgressUseCase: SyncUserProgressUseCase = SyncUserProgressUseCase(repository: userRepository)
    
    // Пример: output для ExercisePickerView
    var fetchExercisesUseCaseOutput: [Exercise] = []
    
    private init() {}
}

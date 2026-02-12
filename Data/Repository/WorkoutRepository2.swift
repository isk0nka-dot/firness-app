import Foundation

final class WorkoutRepository {
    
    private let localDataSource: LocalDataSource
    private let remoteDataSource: RemoteDataSource
    
    init(localDataSource: LocalDataSource, remoteDataSource: RemoteDataSource) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }
    
    // MARK: - Workouts
    
    func fetchWorkouts(completion: @escaping ([Workout]) -> Void) {
        // Сначала локальные данные
        let local = localDataSource.fetchWorkouts().map { $0.toDomain() }
        completion(local)
        
        // Если будет remote API для Workouts, можно потом добавить fetch + save
    }
    
    func addWorkout(_ workout: Workout, completion: ((Bool) -> Void)? = nil) {
        // Сохраняем локально
        localDataSource.saveWorkout(workout)
        completion?(true)
        
        // TODO: добавить синхронизацию с сервером, если будет API
    }
    
    func deleteWorkout(_ workout: Workout, completion: ((Bool) -> Void)? = nil) {
        // Для простоты: удаление локально
        // TODO: реализация через Core Data fetch + delete
        completion?(true)
    }
}

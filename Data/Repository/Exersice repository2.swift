import Foundation

final class ExerciseRepository {
    
    private let localDataSource: LocalDataSource
    private let remoteDataSource: RemoteDataSource
    private let firebaseManager: FirebaseManager
    
    init(localDataSource: LocalDataSource,
         remoteDataSource: RemoteDataSource,
         firebaseManager: FirebaseManager) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
        self.firebaseManager = firebaseManager
    }
    
    // MARK: - Local + Remote
    func fetchExercises(page: Int = 1, query: String? = nil, completion: @escaping ([Exercise]) -> Void) {
        // Сначала локально
        let local = localDataSource.fetchExercises().map { $0.toDomain() }
        if !local.isEmpty {
            completion(local)
        }
        // Потом remote + кеш
        remoteDataSource.fetchExercises(page: page, query: query) { [weak self] remoteExercises in
            self?.localDataSource.saveExercises(remoteExercises)
            completion(remoteExercises)
        }
    }
    
    // MARK: - Firebase comments
    func fetchComments(forExerciseId exerciseId: String, completion: @escaping ([Comment]) -> Void) {
        firebaseManager.fetchComments(forExerciseId: exerciseId, completion: completion)
    }
    
    func addComment(_ comment: Comment, toExerciseId exerciseId: String) {
        firebaseManager.addComment(comment, toExerciseId: exerciseId)
    }
}

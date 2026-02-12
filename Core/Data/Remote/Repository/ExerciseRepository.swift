import Foundation
import CoreData

final class ExerciseRepository {
    
    private let network: NetworkManager
    private let firebase: FirebaseManager
    private let local: CoreDataStack
    
    init(network: NetworkManager, firebase: FirebaseManager, local: CoreDataStack) {
        self.network = network
        self.firebase = firebase
        self.local = local
    }
    
    // MARK: - Fetch exercises with pagination and search
    func fetchExercises(page: Int = 1, pageSize: Int = 20, query: String? = nil,
                        completion: @escaping (Result<[ExerciseEntity], Error>) -> Void) {
        
        // 1. Если есть интернет — fetch с API
        network.get(endpoint: Constants.API.exercisesEndpoint) { (result: Result<[ExerciseAPIModel], NetworkError>) in
            switch result {
            case .success(let apiModels):
                // Сохраняем в Core Data
                let entities = apiModels.map { apiModel -> ExerciseEntity in
                    let entity = self.local.fetch(ExerciseEntity.self, predicate: NSPredicate(format: "id == %@", apiModel.id)).first
                        ?? ExerciseEntity(context: self.local.context)
                    entity.id = apiModel.id
                    entity.name = apiModel.name
                    entity.descriptionText = apiModel.description
                    entity.category = apiModel.category
                    entity.imageUrl = apiModel.imageUrl
                    entity.difficulty = Int16(apiModel.difficulty)
                    entity.createdAt = Date()
                    return entity
                }
                self.local.saveContext()
                completion(.success(entities))
                
            case .failure:
                // Если нет сети — fetch с Core Data
                let cached = self.local.fetch(ExerciseEntity.self)
                completion(.success(cached))
            }
        }
    }
    
    // MARK: - Firebase Comments
    func fetchComments(forExerciseId id: String, completion: @escaping ([Comment]) -> Void) {
        firebase.fetchComments(forExerciseId: id, completion: completion)
    }
    
    func addComment(_ comment: Comment, toExerciseId id: String) {
        firebase.addComment(comment, toExerciseId: id)
    }
    
    func deleteComment(_ commentId: String, fromExerciseId id: String) {
        firebase.deleteComment(commentId, fromExerciseId: id)
    }
}

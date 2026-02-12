import Foundation

final class WorkoutRepository {
    
    private let network: NetworkManager
    private let firebase: FirebaseManager
    private let local: CoreDataStack
    
    init(network: NetworkManager, firebase: FirebaseManager, local: CoreDataStack) {
        self.network = network
        self.firebase = firebase
        self.local = local
    }
    
    // MARK: - Fetch workouts
    func fetchWorkouts(page: Int = 1, pageSize: Int = 20,
                       completion: @escaping (Result<[WorkoutEntity], Error>) -> Void) {
        
        network.get(endpoint: Constants.API.workoutsEndpoint) { (result: Result<[WorkoutAPIModel], NetworkError>) in
            switch result {
            case .success(let apiModels):
                let entities = apiModels.map { apiModel -> WorkoutEntity in
                    let entity = self.local.fetch(WorkoutEntity.self, predicate: NSPredicate(format: "id == %@", apiModel.id)).first
                        ?? WorkoutEntity(context: self.local.context)
                    
                    entity.id = apiModel.id
                    entity.name = apiModel.name
                    entity.date = ISO8601DateFormatter().date(from: apiModel.date) ?? Date()
                    entity.notes = apiModel.notes
                    entity.duration = Int16(apiModel.duration)
                    
                    // Exercises relationship — только IDs, будем подтягивать позже
                    return entity
                }
                self.local.saveContext()
                completion(.success(entities))
            case .failure:
                let cached = self.local.fetch(WorkoutEntity.self)
                completion(.success(cached))
            }
        }
    }
    
    // MARK: - Add Workout locally
    func addWorkout(_ workout: WorkoutEntity) {
        local.saveContext()
    }
}

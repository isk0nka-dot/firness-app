import Foundation

final class FitnessAPI {
    
    static let shared = FitnessAPI()
    private init() {}
    
    // MARK: - Получить список упражнений с пагинацией и поиском
    func fetchExercises(page: Int = 1,
                        pageSize: Int = 20,
                        query: String? = nil,
                        completion: @escaping (Result<[ExerciseAPIModel], NetworkError>) -> Void) {
        
        var queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]
        
        if let query = query, !query.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: query))
        }
        
        NetworkManager.shared.get(endpoint: Constants.API.exercisesEndpoint, queryItems: queryItems, completion: completion)
    }
    
    // MARK: - Получить тренировки
    func fetchWorkouts(page: Int = 1,
                       pageSize: Int = 20,
                       completion: @escaping (Result<[WorkoutAPIModel], NetworkError>) -> Void) {
        
        let queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "pageSize", value: "\(pageSize)")
        ]
        
        NetworkManager.shared.get(endpoint: Constants.API.workoutsEndpoint, queryItems: queryItems, completion: completion)
    }
}

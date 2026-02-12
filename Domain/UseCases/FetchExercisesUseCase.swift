import Foundation

final class FetchExercisesUseCase {
    
    private let repository: ExerciseRepository
    
    init(repository: ExerciseRepository) {
        self.repository = repository
    }
    
    func execute(page: Int = 1, query: String? = nil, completion: @escaping ([Exercise]) -> Void) {
        repository.fetchExercises(page: page, query: query) { result in
            switch result {
            case .success(let entities):
                let domainModels = entities.map { entity in
                    Exercise(
                        id: entity.id,
                        name: entity.name,
                        description: entity.descriptionText,
                        category: entity.category,
                        imageUrl: entity.imageUrl.flatMap(URL.init),
                        difficulty: Int(entity.difficulty),
                        createdAt: entity.createdAt
                    )
                }
                completion(domainModels)
            case .failure:
                completion([])
            }
        }
    }
}

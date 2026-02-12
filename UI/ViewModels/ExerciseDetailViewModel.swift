import Foundation
import Combine

final class ExerciseDetailViewModel: ObservableObject {
    
    @Published var exercise: Exercise
    @Published var comments: [Comment] = []
    
    private let repository: ExerciseRepository
    
    init(exercise: Exercise, repository: ExerciseRepository = DIContainer.shared.exerciseRepository) {
        self.exercise = exercise
        self.repository = repository
    }
    
    func fetchComments() {
        repository.fetchComments(forExerciseId: exercise.id) { [weak self] comments in
            DispatchQueue.main.async {
                self?.comments = comments
            }
        }
    }
    
    func addComment(_ text: String) {
        let comment = Comment(id: UUID().uuidString, text: text, author: "CurrentUser", date: Date())
        repository.addComment(comment, toExerciseId: exercise.id)
        comments.append(comment) // UI обновляется сразу
    }
}

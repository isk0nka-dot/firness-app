import Foundation

final class ExerciseValidator {
    
    static func validate(name: String, description: String, category: String) -> Bool {
        guard !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        guard !description.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        guard !category.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return false }
        return true
    }
    
    static func difficultyLevel(for exercise: Exercise) -> String {
        switch exercise.difficulty {
        case 1...3: return "Beginner"
        case 4...6: return "Intermediate"
        case 7...10: return "Advanced"
        default: return "Unknown"
        }
    }
}

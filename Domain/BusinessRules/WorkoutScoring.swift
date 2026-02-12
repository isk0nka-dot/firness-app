import Foundation

final class WorkoutScoring {
    
    static func score(workout: Workout) -> Int {
        // Простейший scoring
        let exerciseScore = workout.exercises.reduce(0) { $0 + $1.difficulty }
        let durationBonus = workout.duration / 10
        return exerciseScore + durationBonus
    }
    
    static func rating(for score: Int) -> String {
        switch score {
        case 0..<10: return "Easy"
        case 10..<20: return "Medium"
        default: return "Hard"
        }
    }
}

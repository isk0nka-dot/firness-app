import Foundation

struct Workout: Identifiable {
    let id: String
    let name: String
    let date: Date
    let exercises: [Exercise]
    let notes: String?
    let duration: Int // in minutes
}

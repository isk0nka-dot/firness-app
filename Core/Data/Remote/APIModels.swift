import Foundation

// Модель упражнения, получаемая с внешнего API
struct ExerciseAPIModel: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
    let category: String
    let imageUrl: String?
    let difficulty: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case category
        case imageUrl = "image_url"
        case difficulty
    }
}

// Модель тренировки, получаемая с внешнего API
struct WorkoutAPIModel: Codable, Identifiable {
    let id: String
    let name: String
    let date: String   // ISO8601, потом конвертируем в Date
    let exerciseIds: [String]
    let notes: String?
    let duration: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date
        case exerciseIds = "exercises"
        case notes
        case duration
    }
}

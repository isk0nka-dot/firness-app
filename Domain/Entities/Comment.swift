import Foundation

struct Comment: Identifiable, Codable, Equatable {
    let id: String
    let text: String
    let author: String
    let date: Date
}

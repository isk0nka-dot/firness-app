import Foundation

struct Exercise: Identifiable {
    let id: String
    let name: String
    let description: String
    let category: String
    let imageUrl: URL?
    let difficulty: Int
    let createdAt: Date
}

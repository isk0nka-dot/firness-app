import Foundation
import FirebaseDatabase

final class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let db = Database.database().reference()
    
    private init() {}
    
    func fetchComments(forExerciseId exerciseId: String, completion: @escaping ([Comment]) -> Void) {
        db.child("comments").child(exerciseId).observe(.value) { snapshot in
            var comments: [Comment] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let data = try? JSONSerialization.data(withJSONObject: dict),
                   let comment = try? JSONDecoder().decode(Comment.self, from: data) {
                    comments.append(comment)
                }
            }
            completion(comments.sorted { $0.date < $1.date })
        }
    }
    
    func addComment(_ comment: Comment, toExerciseId exerciseId: String) {
        let commentRef = db.child("comments").child(exerciseId).child(comment.id)
        if let data = try? JSONEncoder().encode(comment),
           let dict = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            commentRef.setValue(dict)
        }
    }
}

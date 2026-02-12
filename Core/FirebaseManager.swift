import Foundation
import FirebaseDatabase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    private init() {}
    
    private let db = Database.database().reference()
    
    // MARK: - Comments CRUD
    
    func fetchComments(forExerciseId exerciseId: String,
                       completion: @escaping ([Comment]) -> Void) {
        db.child(Constants.Firebase.commentsPath)
            .child(exerciseId)
            .observe(.value) { snapshot in
                var comments: [Comment] = []
                
                for child in snapshot.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any],
                       let comment = Comment.from(dict: dict, id: snap.key) {
                        comments.append(comment)
                    }
                }
                
                completion(comments)
            }
    }
    
    func addComment(_ comment: Comment, toExerciseId exerciseId: String) {
        let ref = db.child(Constants.Firebase.commentsPath).child(exerciseId).childByAutoId()
        ref.setValue(comment.toDict())
    }
    
    func deleteComment(_ commentId: String, fromExerciseId exerciseId: String) {
        db.child(Constants.Firebase.commentsPath).child(exerciseId).child(commentId).removeValue()
    }
}

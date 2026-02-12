import Foundation
import CoreData

@objc(ExerciseEntity)
public class ExerciseEntity: NSManagedObject {

    func toDomain() -> Exercise {
        Exercise(
            id: id ?? UUID().uuidString,
            name: name ?? "",
            description: desc ?? "",
            category: category ?? "",
            imageUrl: imageUrl != nil ? URL(string: imageUrl!) : nil
        )
    }
}

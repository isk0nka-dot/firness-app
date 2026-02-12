import Foundation
import CoreData

extension ExerciseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseEntity> {
        return NSFetchRequest<ExerciseEntity>(entityName: "ExerciseEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var descriptionText: String
    @NSManaged public var category: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var difficulty: Int16
    @NSManaged public var createdAt: Date
}

extension ExerciseEntity : Identifiable {

}

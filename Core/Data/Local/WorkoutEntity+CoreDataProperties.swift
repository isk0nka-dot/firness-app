import Foundation
import CoreData

extension WorkoutEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEntity> {
        return NSFetchRequest<WorkoutEntity>(entityName: "WorkoutEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var date: Date
    @NSManaged public var exercises: NSSet?   // relationship to ExerciseEntity
    @NSManaged public var notes: String?
    @NSManaged public var duration: Int16      // in minutes
}

extension WorkoutEntity : Identifiable {

}

// MARK: - Relationship convenience
extension WorkoutEntity {
    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: ExerciseEntity)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: ExerciseEntity)
    
    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)
    
    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)
}

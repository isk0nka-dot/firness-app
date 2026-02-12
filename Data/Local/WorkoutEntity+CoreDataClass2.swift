import Foundation
import CoreData

@objc(WorkoutEntity)
public class WorkoutEntity: NSManagedObject {

    func toDomain() -> Workout {
        Workout(
            id: id ?? UUID().uuidString,
            name: name ?? "",
            date: date ?? Date(),
            duration: Int(duration),
            notes: notes ?? "",
            exercises: [] // можно связать позже через relationship
        )
    }
}

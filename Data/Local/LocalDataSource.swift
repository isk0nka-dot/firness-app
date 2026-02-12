import Foundation
import CoreData

final class LocalDataSource {
    
    static let shared = LocalDataSource()
    
    private let coreDataStack = CoreDataStack.shared
    
    private init() {}
    
    // MARK: - Exercises
    func fetchExercises() -> [ExerciseEntity] {
        let context = coreDataStack.context
        let request: NSFetchRequest<ExerciseEntity> = ExerciseEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Core Data fetchExercises failed: \(error)")
            return []
        }
    }
    
    func saveExercises(_ exercises: [Exercise]) {
        let context = coreDataStack.context
        exercises.forEach { exercise in
            let entity = ExerciseEntity(context: context)
            entity.id = exercise.id
            entity.name = exercise.name
            entity.category = exercise.category
            entity.desc = exercise.description
            entity.imageUrl = exercise.imageUrl?.absoluteString
        }
        coreDataStack.saveContext()
    }
    
    // MARK: - Workouts
    func saveWorkout(_ workout: Workout) {
        let context = coreDataStack.context
        let entity = WorkoutEntity(context: context)
        entity.id = workout.id
        entity.name = workout.name
        entity.date = workout.date
        entity.notes = workout.notes
        entity.duration = Int16(workout.duration)
        // TODO: связать упражнения через Core Data relationship
        coreDataStack.saveContext()
    }
    
    func fetchWorkouts() -> [WorkoutEntity] {
        let context = coreDataStack.context
        let request: NSFetchRequest<WorkoutEntity> = WorkoutEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Core Data fetchWorkouts failed: \(error)")
            return []
        }
    }
}

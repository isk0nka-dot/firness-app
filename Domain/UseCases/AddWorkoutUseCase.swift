import Foundation

final class AddWorkoutUseCase {
    
    private let repository: WorkoutRepository
    
    init(repository: WorkoutRepository) {
        self.repository = repository
    }
    
    func execute(workout: Workout) {
        let entity = WorkoutEntity(context: CoreDataStack.shared.context)
        entity.id = workout.id
        entity.name = workout.name
        entity.date = workout.date
        entity.notes = workout.notes
        entity.duration = Int16(workout.duration)
        
        workout.exercises.forEach { exercise in
            let exerciseEntity = ExerciseEntity(context: CoreDataStack.shared.context)
            exerciseEntity.id = exercise.id
            exerciseEntity.name = exercise.name
            exerciseEntity.descriptionText = exercise.description
            exerciseEntity.category = exercise.category
            exerciseEntity.imageUrl = exercise.imageUrl?.absoluteString
            exerciseEntity.difficulty = Int16(exercise.difficulty)
            exerciseEntity.createdAt = exercise.createdAt
            
            entity.addToExercises(exerciseEntity)
        }
        
        repository.addWorkout(entity)
    }
}

import SwiftUI
import Combine

final class WorkoutFormViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var date: Date = Date()
    @Published var notes: String = ""
    @Published var selectedExercises: [Exercise] = []
    @Published var showExercisePicker: Bool = false
    @Published var errorMessage: String?
    
    private let addWorkoutUseCase: AddWorkoutUseCase
    
    init(addWorkoutUseCase: AddWorkoutUseCase = DIContainer.shared.addWorkoutUseCase) {
        self.addWorkoutUseCase = addWorkoutUseCase
    }
    
    func saveWorkout() {
        guard ExerciseValidator.validate(name: name, description: notes, category: "General") else {
            errorMessage = "Please fill all required fields."
            return
        }
        
        guard !selectedExercises.isEmpty else {
            errorMessage = "Add at least one exercise."
            return
        }
        
        let workout = Workout(
            id: UUID().uuidString,
            name: name,
            date: date,
            exercises: selectedExercises,
            notes: notes,
            duration: selectedExercises.count * 10 // пример: 10 мин на упражнение
        )
        
        addWorkoutUseCase.execute(workout: workout)
        errorMessage = nil
    }
    
    func removeExercise(at offsets: IndexSet) {
        selectedExercises.remove(atOffsets: offsets)
    }
}

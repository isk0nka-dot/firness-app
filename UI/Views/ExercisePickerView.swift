import SwiftUI

struct ExercisePickerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedExercises: [Exercise]
    
    // Для примера: можно подгружать через FetchExercisesUseCase
    @State private var allExercises: [Exercise] = []
    
    var body: some View {
        NavigationView {
            List(allExercises) { exercise in
                Button(action: {
                    if !selectedExercises.contains(where: { $0.id == exercise.id }) {
                        selectedExercises.append(exercise)
                    }
                }) {
                    HStack {
                        Text(exercise.name)
                        Spacer()
                        if selectedExercises.contains(where: { $0.id == exercise.id }) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
            }
            .navigationTitle("Select Exercises")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .onAppear {
            // Здесь можно вызвать useCase для загрузки упражнений
            allExercises = DIContainer.shared.fetchExercisesUseCaseOutput
        }
    }
}

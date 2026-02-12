import SwiftUI

struct WorkoutFormView: View {
    
    @StateObject var viewModel: WorkoutFormViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Info")) {
                    TextField("Workout Name", text: $viewModel.name)
                    DatePicker("Date", selection: $viewModel.date, displayedComponents: .date)
                    TextField("Notes", text: $viewModel.notes)
                }
                
                Section(header: Text("Exercises")) {
                    ForEach(viewModel.selectedExercises) { exercise in
                        ExerciseRowView(exercise: exercise)
                    }
                    .onDelete(perform: viewModel.removeExercise)
                    
                    Button("Add Exercise") {
                        viewModel.showExercisePicker = true
                    }
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button(action: {
                    viewModel.saveWorkout()
                }) {
                    Text("Save Workout")
                        .frame(maxWidth: .infinity)
                }
            }
            .navigationTitle("New Workout")
            .sheet(isPresented: $viewModel.showExercisePicker) {
                ExercisePickerView(selectedExercises: $viewModel.selectedExercises)
            }
        }
    }
}

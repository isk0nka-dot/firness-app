import SwiftUI

struct SearchExerciseView: View {
    
    @StateObject var viewModel: SearchExerciseViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField("Search exercises...", text: $viewModel.searchQuery)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                // Filters
                HStack {
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        Text("All").tag("All")
                        ForEach(viewModel.categories, id: \.self) { category in
                            Text(category).tag(category)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    
                    Picker("Difficulty", selection: $viewModel.selectedDifficulty) {
                        Text("All").tag("All")
                        Text("Beginner").tag("Beginner")
                        Text("Intermediate").tag("Intermediate")
                        Text("Advanced").tag("Advanced")
                    }
                    .pickerStyle(MenuPickerStyle())
                }
                .padding(.horizontal)
                
                if viewModel.isLoading && viewModel.exercises.isEmpty {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.exercises.isEmpty {
                    Text("No exercises found")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.exercises) { exercise in
                        ExerciseRowView(exercise: exercise)
                            .onAppear {
                                viewModel.loadMoreIfNeeded(currentItem: exercise)
                            }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Search Exercises")
        }
        .onAppear {
            viewModel.fetchExercises()
        }
    }
}

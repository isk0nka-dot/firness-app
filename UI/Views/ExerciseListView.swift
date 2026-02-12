import SwiftUI
import Kingfisher

struct ExerciseListView: View {
    
    @StateObject private var viewModel: ExerciseListViewModel
    
    init(viewModel: ExerciseListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // Search bar
                TextField("Search exercises...", text: $viewModel.searchQuery)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                if viewModel.isLoading && viewModel.exercises.isEmpty {
                    ProgressView("Loading...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if viewModel.exercises.isEmpty {
                    Text("No exercises found")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.exercises) { exercise in
                            NavigationLink(destination: ExerciseDetailView(viewModel: ExerciseDetailViewModel(exercise: exercise))) {
                                ExerciseRowView(exercise: exercise)
                            }
                            .onAppear {
                                viewModel.loadMoreIfNeeded(currentItem: exercise)
                            }
                        }
                        if viewModel.isLoading {
                            ProgressView()
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .listStyle(PlainListStyle())
                }
            }
            .navigationTitle("Exercises")
        }
        .onAppear {
            viewModel.fetchExercises()
        }
    }
}

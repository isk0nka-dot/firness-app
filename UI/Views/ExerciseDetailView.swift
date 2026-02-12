import SwiftUI

struct ExerciseDetailView: View {
    
    @StateObject var viewModel: ExerciseDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                if let url = viewModel.exercise.imageUrl {
                    KFImage(url)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                }
                
                Text(viewModel.exercise.name)
                    .font(.largeTitle)
                    .bold()
                
                Text(viewModel.exercise.category)
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Text(viewModel.exercise.description)
                    .font(.body)
                
                Text("Difficulty: \(ExerciseValidator.difficultyLevel(for: viewModel.exercise))")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Divider()
                
                CommentsView(comments: $viewModel.comments, onAdd: { text in
                    viewModel.addComment(text)
                })
            }
            .padding()
        }
        .navigationTitle("Exercise Detail")
        .onAppear {
            viewModel.fetchComments()
        }
    }
}

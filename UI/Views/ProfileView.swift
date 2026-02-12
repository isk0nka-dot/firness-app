import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.user.name)
                        .font(.largeTitle)
                        .bold()
                    Text(viewModel.user.email)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)
                
                Divider()
                
                Text("Favorite Exercises")
                    .font(.headline)
                    .padding(.horizontal)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.user.favoriteExercises) { exercise in
                            ExerciseRowView(exercise: exercise)
                                .frame(width: 200)
                        }
                    }
                    .padding(.horizontal)
                }
                
                Text("Completed Workouts")
                    .font(.headline)
                    .padding(.horizontal)
                
                List(viewModel.user.completedWorkouts) { workout in
                    VStack(alignment: .leading) {
                        Text(workout.name)
                            .font(.headline)
                        Text("Exercises: \(workout.exercises.count), Duration: \(workout.duration) min")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.signOut()
                }) {
                    Text("Sign Out")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.loadUserData()
        }
    }
}

import SwiftUI
import Kingfisher

struct ExerciseRowView: View {
    
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 16) {
            if let url = exercise.imageUrl {
                KFImage(url)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 80, height: 80)
                    .cornerRadius(8)
                    .overlay(Text("No Image").font(.caption).foregroundColor(.gray))
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(exercise.name)
                    .font(.headline)
                Text(exercise.category)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(ExerciseValidator.difficultyLevel(for: exercise))
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

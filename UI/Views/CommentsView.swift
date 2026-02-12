import SwiftUI

struct CommentsView: View {
    
    @Binding var comments: [Comment]
    var onAdd: (String) -> Void
    
    @State private var newCommentText: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Comments")
                .font(.headline)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(comments) { comment in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(comment.author)
                                    .font(.subheadline)
                                    .bold()
                                Text(comment.text)
                                    .font(.body)
                            }
                            Spacer()
                            Text(Self.dateFormatter.string(from: comment.date))
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(4)
                        .background(Color(.systemGray6))
                        .cornerRadius(6)
                    }
                }
            }
            .frame(height: 200)
            
            HStack {
                TextField("Add comment...", text: $newCommentText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    guard !newCommentText.isEmpty else { return }
                    onAdd(newCommentText)
                    newCommentText = ""
                }) {
                    Text("Send")
                }
            }
        }
        .padding(.vertical)
    }
    
    private static let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }()
}

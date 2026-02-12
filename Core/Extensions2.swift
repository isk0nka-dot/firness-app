import SwiftUI
import Foundation

// MARK: - Date
extension Date {
    func formattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

// MARK: - String
extension String {
    func capitalizedFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}

// MARK: - View
extension View {
    func cardStyle() -> some View {
        self
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(Constants.UI.cornerRadius)
            .shadow(radius: 2)
    }
}

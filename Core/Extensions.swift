import SwiftUI

// MARK: - View Extensions
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder),
                                        to: nil, from: nil, for: nil)
    }
}

// MARK: - String Extensions
extension String {
    var isValidEmail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self)
    }
    
    var isNotEmpty: Bool { !self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
}

// MARK: - Date Extensions
extension Date {
    func formatted(_ format: String = "yyyy-MM-dd HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: - Color Extensions
extension Color {
    static let primaryGreen = Color("PrimaryGreen") // добавить в Assets
    static let secondaryGray = Color("SecondaryGray")
}

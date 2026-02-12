import Foundation
import SwiftUI

struct Constants {
    
    struct Colors {
        static let primary = Color("PrimaryColor")
        static let secondary = Color("SecondaryColor")
        static let background = Color("BackgroundColor")
        static let accent = Color("AccentColor")
    }
    
    struct Fonts {
        static let title = Font.system(size: 24, weight: .bold)
        static let subtitle = Font.system(size: 18, weight: .medium)
        static let body = Font.system(size: 16, weight: .regular)
    }
    
    struct API {
        static let baseURL = "https://api.example.com/fitness"
        static let pageSize = 20
    }
    
    struct Firebase {
        static let commentsPath = "comments"
        static let usersPath = "users"
    }
    
    struct UI {
        static let cornerRadius: CGFloat = 8
        static let padding: CGFloat = 16
    }
}

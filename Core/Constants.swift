import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://api.fitnessapp.com/v1/"
        static let exercisesEndpoint = "exercises"
        static let workoutsEndpoint = "workouts"
        static let timeout: TimeInterval = 30
    }
    
    struct Firebase {
        static let commentsPath = "comments"
        static let likesPath = "likes"
    }
    
    struct UI {
        static let placeholderImage = "placeholder_exercise"
        static let defaultAvatar = "default_avatar"
    }
}

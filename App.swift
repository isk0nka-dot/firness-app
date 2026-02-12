import SwiftUI
import Firebase

@main
struct FitnessApp: App {
    
    // Инициализация Firebase при старте
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            // DIContainer создаёт репозитории и ViewModels
            let container = DIContainer.shared
            ExerciseListView(viewModel: container.makeExerciseListViewModel())
        }
    }
}

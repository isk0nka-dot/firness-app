import Foundation
import Combine

final class SearchExerciseViewModel: ObservableObject {
    
    @Published var exercises: [Exercise] = []
    @Published var searchQuery: String = ""
    @Published var selectedCategory: String = "All"
    @Published var selectedDifficulty: String = "All"
    @Published var isLoading = false
    
    private let fetchUseCase: FetchExercisesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var canLoadMore = true
    private var isFetching = false
    
    let categories = ["Strength", "Cardio", "Flexibility", "Balance"]
    
    init(fetchUseCase: FetchExercisesUseCase = DIContainer.shared.fetchExercisesUseCase) {
        self.fetchUseCase = fetchUseCase
        
        // Debounce searchQuery + filters
        Publishers.CombineLatest3($searchQuery, $selectedCategory, $selectedDifficulty)
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .sink { [weak self] (_, _, _) in
                self?.refresh()
            }
            .store(in: &cancellables)
    }
    
    func fetchExercises() {
        guard !isFetching, canLoadMore else { return }
        isFetching = true
        isLoading = true
        
        let query = searchQuery.isEmpty ? nil : searchQuery
        
        fetchUseCase.execute(page: currentPage, query: query) { [weak self] newExercises in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                // Apply filters
                var filtered = newExercises
                if self.selectedCategory != "All" {
                    filtered = filtered.filter { $0.category == self.selectedCategory }
                }
                if self.selectedDifficulty != "All" {
                    filtered = filtered.filter { ExerciseValidator.difficultyLevel(for: $0) == self.selectedDifficulty }
                }
                
                if self.currentPage == 1 {
                    self.exercises = filtered
                } else {
                    self.exercises.append(contentsOf: filtered)
                }
                
                self.canLoadMore = !filtered.isEmpty
                self.isLoading = false
                self.isFetching = false
                self.currentPage += 1
            }
        }
    }
    
    func refresh() {
        currentPage = 1
        canLoadMore = true
        fetchExercises()
    }
    
    func loadMoreIfNeeded(currentItem item: Exercise) {
        if exercises.last == item {
            fetchExercises()
        }
    }
}

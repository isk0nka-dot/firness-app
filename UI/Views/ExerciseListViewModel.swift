import Foundation
import Combine

final class ExerciseListViewModel: ObservableObject {
    
    @Published var exercises: [Exercise] = []
    @Published var searchQuery: String = ""
    @Published var isLoading = false
    
    private let fetchUseCase: FetchExercisesUseCase
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage = 1
    private var canLoadMore = true
    private var isFetching = false
    
    init(fetchUseCase: FetchExercisesUseCase) {
        self.fetchUseCase = fetchUseCase
        
        // Debounced search
        $searchQuery
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.refresh(query: query)
            }
            .store(in: &cancellables)
    }
    
    func fetchExercises() {
        guard !isFetching, canLoadMore else { return }
        isFetching = true
        isLoading = true
        
        fetchUseCase.execute(page: currentPage, query: searchQuery) { [weak self] newExercises in
            DispatchQueue.main.async {
                guard let self = self else { return }
                if self.currentPage == 1 {
                    self.exercises = newExercises
                } else {
                    self.exercises.append(contentsOf: newExercises)
                }
                self.canLoadMore = !newExercises.isEmpty
                self.isLoading = false
                self.isFetching = false
                self.currentPage += 1
            }
        }
    }
    
    func refresh(query: String?) {
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

import Foundation

final class RemoteDataSource {
    
    static let shared = RemoteDataSource()
    
    private let baseURL = "https://api.example.com/fitness" // пример
    
    private init() {}
    
    func fetchExercises(page: Int, query: String?, completion: @escaping ([Exercise]) -> Void) {
        var components = URLComponents(string: "\(baseURL)/exercises")!
        var queryItems = [URLQueryItem(name: "page", value: "\(page)")]
        if let q = query, !q.isEmpty {
            queryItems.append(URLQueryItem(name: "search", value: q))
        }
        components.queryItems = queryItems
        
        let request = URLRequest(url: components.url!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("RemoteDataSource fetchExercises failed: \(error?.localizedDescription ?? "no data")")
                completion([])
                return
            }
            do {
                let apiResponse = try JSONDecoder().decode([Exercise].self, from: data)
                completion(apiResponse)
            } catch {
                print("JSON decode failed: \(error)")
                completion([])
            }
        }.resume()
    }
}

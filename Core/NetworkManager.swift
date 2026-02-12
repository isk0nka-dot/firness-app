import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingError(Error)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = Constants.API.timeout
        config.timeoutIntervalForResource = Constants.API.timeout
        return URLSession(configuration: config)
    }()
    
    // Универсальный GET-запрос
    func get<T: Decodable>(endpoint: String,
                           queryItems: [URLQueryItem]? = nil,
                           completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard var urlComponents = URLComponents(string: Constants.API.baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        task.resume()
    }
}

import Foundation

public class APIService {
    
    
    public static let shared = APIService()
    
    func getJSON<T: Decodable>(urlString: String,
                                      dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate,
                                      keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys ,
                                      completion: @escaping (Result<T, APIError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.error("Error: Invalid URL")))
            print("failure 1")
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let err = error {
                completion(.failure(.error("Error: \(err.localizedDescription)")))
                print("failure 2")
                return
            }
            
            
            guard let data = data else {
                completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: ""))))
                print("failure 3")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = dateDecodingStrategy
            decoder.keyDecodingStrategy = keyDecodingStrategy
            
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
                return
            } catch let decodingError {
                print("failure 4")
                completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
                return
            }
            
        }.resume()
        
    }
}

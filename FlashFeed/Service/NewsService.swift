//
//  NewsService.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation
import Combine

protocol NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError>
}

struct NewsServiceImpl: NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse, APIError> {
        print("Perform NewsServiceImpl.request")
        print("getting articles from \(endpoint.urlRequest)")
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError{ _ in APIError.unknown}
            .flatMap { data, response -> AnyPublisher<NewsResponse, APIError> in
                guard let response = response as? HTTPURLResponse else {
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if (200...299).contains(response.statusCode) {
                    print(response.statusCode)
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { _ in
                            print("error herrrre")
                            print(data)
                            return APIError.decodingEror}
                        .eraseToAnyPublisher()            
                } else {
                    print("error here")
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    
}

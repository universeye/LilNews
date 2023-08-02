//
//  NewsViewModel.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation
import Combine

protocol NewsViewModel {
    func getArticles()
    var isLoading: Bool { get }
}


class NewsViewModelImpl: ObservableObject, NewsViewModel {
    var isLoading: Bool {
        state == .loading
    }
    private let service: NewsService
    
    private(set) var articles = [NewsResponse.Articles]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles() {
        print("perform NewsViewModelImpl.getArticles")
        print("Loading...")
        self.state = .loading
        let cancellable = service.request(from: .getNews)
            .sink { (res) in
                switch res {
                
                case .finished:
                    //send back the articles
                    print("sink success")
                    self.state = .success(content: self.articles)
                case .failure(let error):
                    //send back the error
                    print("fail: \(error.localizedDescription)")
                    self.state = .failed(error: error)
                }
            } receiveValue: { (response) in
                self.articles = response.articles
            }
        self.cancellables.insert(cancellable)

    }
    
    
    //another method of api calls
    func getNews() {
        let urlstringg = "https://api.lil.software/news"
        let apiService = APIService.shared
        apiService.getJSON(urlString: urlstringg) { (result: Result<NewsResponse, APIError>) in
            switch result {
            
            case .success(let artic):
                self.state = .success(content: self.articles)
                self.articles = artic.articles
            case .failure(let apierror):
                switch apierror {
                case .error(_):
                    DispatchQueue.main.async {
                        self.state = .failed(error: apierror)
                        print(apierror.errorDescription!)
                    }
                    
                case .decodingEror:
                    DispatchQueue.main.async {
                        self.state = .failed(error: apierror)
                        print(apierror.errorDescription!)
                    }
                case .errorCode(_):
                    DispatchQueue.main.async {
                    self.state = .failed(error: apierror)
                    print(apierror.errorDescription!)
                }
                case .unknown:
                    DispatchQueue.main.async {
                        self.state = .failed(error: apierror)
                        print(apierror.errorDescription!)
                    }
                }
            }
        }
    }
}

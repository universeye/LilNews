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
}


class NewsViewModelImpl: ObservableObject, NewsViewModel {
    
    private let service: NewsService
    
    private(set) var articles = [NewsResponse.Articles]()
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: ResultState = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles() {
        
    }
    
    
}

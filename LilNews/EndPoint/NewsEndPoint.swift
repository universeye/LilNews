//
//  NewsEndPoint.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseurl: URL { get }
    var path: String { get }
}

enum NewsAPI {
    case getNews
}


extension NewsAPI: APIBuilder {
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseurl)
        //.appendingPathComponent(self.path)
    }
    
    var baseurl: URL {
        switch self {
        case .getNews:
            return URL(string: "https://api.lil.software/news")!
        }
    }
    
    var path: String {
        return "/news"
    }
    
    
}

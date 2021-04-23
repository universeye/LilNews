//
//  NewsResponse.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation


struct NewsResponse: Codable {
    let articles: [Articles]
}

extension NewsResponse {
    struct Articles: Codable, Identifiable {
        var id = UUID()
        let author: String?
        let url: URL
        let source: String
        let title: String
        let articleDescription: String?
        let image: URL?
        let date: Date
    }
}

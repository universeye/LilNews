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
//articles[0].author
//articles[1].url
extension NewsResponse {
    struct Articles: Codable, Hashable{
        //var id = UUID()
        let author: String?
        let url: URL
        let source: String
        let title: String
        let description: String?
        let image: URL?
        let date: Date?
    }
    
    
    static var testURL: URL = URL(string: "https://static.foxnews.com/foxnews.com/content/uploads/2021/04/Jerry-Jones-Kyle-Pitts-REUTERS-GETTY.jpg")!
    static var testTitle: String = "Jerry Jones has 'visions of sugar plums' imagining Kyle Pitts with Cowboys - Fox News"
    static var testDescription: String = "Dallas Cowboys owner Jerry Jones is infatuated with Kyle Pitts. And a video surfaced this week that further proved that initial report."
    static var testSource: String = "Fox News"
//
//    static var testArticles = Articles(
//                                            author: nil,
//                                            url: URL(string: "https://static.foxnews.com/foxnews.com/content/uploads/2021/04/Jerry-Jones-Kyle-Pitts-REUTERS-GETTY.jpg")!,
//                                            source: "Fox News",
//                                            title: "Jerry Jones has 'visions of sugar plums' imagining Kyle Pitts with Cowboys - Fox News",
//                                            articleDescription: nil,
//                                            image: URL(string: "https://static.foxnews.com/foxnews.com/content/uploads/2021/04/Jerry-Jones-Kyle-Pitts-REUTERS-GETTY.jpg")!,
//                                            date: nil)
}

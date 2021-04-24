//
//  ContentView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .failed(let error):
                ErrorView(error: error, handler: viewModel.getArticles)
            case .success(let articles):
                NavigationView {
                    List {
                        ForEach(0..<articles.count) { i in
                            ArticleView(articles:viewModel.articles[i])
                        }
                    }
                    .listStyle(PlainListStyle())
                    .navigationTitle("News")
                }
            }
        }
        .onAppear {
            viewModel.getNews()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

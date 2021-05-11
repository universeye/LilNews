//
//  ContentView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.getArticles)
//                case .success(let articles):
//                    List {
//                        ForEach(articles, id: \.self) { article in
//                            ArticleView(articles: article)
//                        }
//                    }
                default:
                    GeometryReader { geo in
                        RefreshScrollView(width: geo.size.width, height: geo.size.height, viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("News")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Refresh") {
                        viewModel.getArticles()
                    }
                }
            })
            
        }
        .onAppear {
            viewModel.getArticles()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

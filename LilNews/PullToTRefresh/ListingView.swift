//
//  ListingView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/11.
//

import SwiftUI

struct ListingView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    @State private var con = 1
    
    var body: some View {
        List(viewModel.isLoading ? NewsResponse.testArticles : viewModel.articles, id: \.self) { article in
            ArticleView(articles: article, isLoading: viewModel.isLoading)
        }
        .refreshable {
            viewModel.getArticles()
        }
        .listStyle(PlainListStyle())
        .onAppear {
            if con == 1 {
                viewModel.getArticles()
                con += 1
            }
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(viewModel: NewsViewModelImpl(service: NewsServiceImpl()))
    }
}

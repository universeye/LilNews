//
//  ListingView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/11.
//

import SwiftUI

struct ListingView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    var body: some View {
        List(viewModel.isLoading ? NewsResponse.testArticles : viewModel.articles, id: \.self) { article in
            ArticleView(articles: article, isLoading: viewModel.isLoading)
        }
        .listStyle(PlainListStyle())
        .onAppear {
            viewModel.getArticles()
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(viewModel: NewsViewModelImpl(service: NewsServiceImpl())).environmentObject(NewsViewModelImpl(service: NewsServiceImpl()))
    }
}

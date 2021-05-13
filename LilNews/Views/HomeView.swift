//
//  ContentView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    @State private var con = 1
    
    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                case .failed(let error):
                    ErrorView(error: error, handler: viewModel.getArticles)
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
            if con == 1 {
                viewModel.getArticles()
                con += 1
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

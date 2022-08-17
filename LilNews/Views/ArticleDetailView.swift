//
//  ArticleDetailView.swift
//  DZ News
//
//  Created by Terry Kuo on 2022/8/17.
//

import SwiftUI

struct ArticleDetailView: View {
    
    let articles: NewsResponse.Articles
    @State private var isShowingSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                if let date = articles.date {
                    HStack {
                        Text(date, style: .date)
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.gray)
                        Text(date, style: .time)
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                    }
                }
                Text(articles.title)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)
                Text(articles.source)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.secondary)
                
                
                AsyncImage(url: articles.image) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(20)
                        .padding(.vertical)
                } placeholder: {
                    Image("demo1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(20)
                        .padding(.vertical)
                        .redacted(reason: .placeholder)
                }
                Text(articles.description ?? "")
                    .font(.system(size: 17, weight: .regular, design: .default))
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Text("Read More")
                        .underline()
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
        }
        .sheet(isPresented: $isShowingSheet) {
            SFSafariView(url: articles.url)
                .ignoresSafeArea()
        }
        
    }
}

struct ArticleDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleDetailView(articles: NewsResponse.testArticles[0])
    }
}

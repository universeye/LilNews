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
    @State private var isAnimating = false
    
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
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0), value: isAnimating)
                }
                Text(articles.title)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .multilineTextAlignment(.leading)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.25), value: isAnimating)
                Text(articles.source)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.secondary)
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.45), value: isAnimating)
                
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
                    .opacity(isAnimating ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.65), value: isAnimating)
                Button {
                    isShowingSheet.toggle()
                    
                } label: {
                    Text("Read More")
                        .underline()
                        .opacity(isAnimating ? 1 : 0)
                        .animation(.easeOut(duration: 0.4).delay(0.75), value: isAnimating)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear(perform: {
            
            self.isAnimating = true
            
        })
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

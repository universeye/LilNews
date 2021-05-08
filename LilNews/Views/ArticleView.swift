//
//  ArticleView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import SwiftUI
import URLImage

struct ArticleView: View {
    
    let articles: NewsResponse.Articles
    @State private var isShowingSheet = false
    @State var isLoading: Bool
    
    var body: some View {
        HStack(spacing: 10) {
            
            if let imgURL = articles.image {
                URLImage(url: imgURL,
                         options: URLImageOptions(
                            //identifier: articles.id.uuidString,
                            cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25)),
                         failure: { error, retry in         // Display error and retry button
                            VStack {
                                placeHolderImageView()
                                Text(error.localizedDescription)
                                Button("Retry", action: retry)
                            }
                         },
                         content: { (imagess) in
                            imagess
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                            
                         })
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            } else {
                placeHolderImageView()
            }
            
            VStack (alignment: .leading, spacing: 4) {
                Text(articles.title)
                    .foregroundColor(Color.black)
                    .font(.system(size: 18, weight: .semibold))
                    .truncationMode(.tail)
                    .minimumScaleFactor(0.9)
                    .lineLimit(3)
                Text(articles.source)
                    .foregroundColor(.gray)
                    .font(.footnote)
                
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
                
            }
            .onTapGesture {
                isShowingSheet.toggle()
            }
            .sheet(isPresented: $isShowingSheet) {
                SFSafariView(url: articles.url)
            }
        }
        .padding(.horizontal, 10)
        .redacted(reason: isLoading ? .placeholder : [])
        .allowsHitTesting(!isLoading)
    }
}

struct ArticleView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleView(articles: NewsResponse.testArticles[0], isLoading: false).previewLayout(.sizeThatFits)
    }
}


struct placeHolderImageView: View {
    var body: some View {
        VStack {
            SFSymbols.placeholderImage
                .foregroundColor(.white)
                .background(Color.gray)
                .frame(width: 100, height: 100)
        }
    }
}

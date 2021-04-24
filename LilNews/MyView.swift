//
//  MyView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import SwiftUI
import URLImage

struct MyView: View {
    var url: URL = URL(string: "https://static.foxnews.com/foxnews.com/content/uploads/2021/04/Jerry-Jones-Kyle-Pitts-REUTERS-GETTY.jpg")!
    let id:  UUID
    
    init(url: URL, id: UUID) {
        self.url = url
        self.id = id
        
        formatter = NumberFormatter()
        formatter.numberStyle = .percent
    }
    
    private let formatter: NumberFormatter // Used to format download progress as percentage. Note: this is only for example, better use shared formatter to avoid creating it for every view.
    
    var body: some View {
        URLImage(url: url,
                 options: URLImageOptions(
                    identifier: id.uuidString,      // Custom identifier
                    expireAfter: 300.0,             // Expire after 5 minutes
                    cachePolicy: .returnCacheElseLoad(cacheDelay: nil, downloadDelay: 0.25) // Return cached image or download after delay
                 ),
                 empty: {
                    Text("Nothing here")            // This view is displayed before download starts
                 },
                 inProgress: { progress -> Text in  // Display progress
                    if let progress = progress {
                        return Text(formatter.string(from: progress as NSNumber) ?? "Loading...")
                    }
                    else {
                        return Text("Loading...")
                    }
                 },
                 failure: { error, retry in         // Display error and retry button
                    VStack {
                        Text(error.localizedDescription)
                        Button("Retry", action: retry)
                    }
                 },
                 content: { image in                // Content view
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                 })
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(url: URL(string: "https://static.foxnews.com/foxnews.com/content/uploads/2021/04/Jerry-Jones-Kyle-Pitts-REUTERS-GETTY.jpg")!, id: UUID())
    }
}

//
//  SFSafariView.swift
//  HACKERRNEWS
//
//  Created by Terry Kuo on 2021/4/24.
//

import SwiftUI
import SafariServices

struct SFSafariView: UIViewControllerRepresentable {
    
    
    typealias UIViewControllerType = SFSafariViewController
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
}

struct SFSafariView_Previews: PreviewProvider {
    static var previews: some View {
        SFSafariView(url: URL(string: "www.apple.com.tw")!)
    }
}

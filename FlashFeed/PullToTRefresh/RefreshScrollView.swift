//
//  RefreshScrollView.swift
//  PullToRefresh
//
//  Created by Terry Kuo on 2021/4/24.
//

import UIKit
import SwiftUI

struct RefreshScrollView: UIViewRepresentable {
    
    var width: CGFloat
    var height: CGFloat
    
    var viewModel = NewsViewModelImpl(service: NewsServiceImpl())
    
    func makeUIView(context: Context) -> UIView {
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl(sender:)), for: .allEvents)
        
        let refreshVC = UIHostingController(rootView: ListingView())
        refreshVC.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        scrollView.addSubview(refreshVC.view)
        return scrollView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, viewModel: viewModel)
    }
    
    class Coordinator: NSObject {
        var refreshScrollView: RefreshScrollView
        var viewModel: NewsViewModelImpl
        
        init(_ refreshScrollView: RefreshScrollView, viewModel: NewsViewModelImpl) {
            self.refreshScrollView = refreshScrollView
            self.viewModel = viewModel
        }
        
        @objc func handleRefreshControl(sender: UIRefreshControl) { //handle what to do when pull is released
            sender.endRefreshing()
            print("refreshing...")
            viewModel.getArticles()
        }
        
    }
    
   
}

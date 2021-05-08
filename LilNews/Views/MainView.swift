//
//  HomeView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/8.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    SFSymbols.newsIcon
                    Text("News")
                }
            
            SettingsView()
                .tabItem {
                    SFSymbols.settings
                    Text("Settings")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

//
//  HomeView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/8.
//

import SwiftUI

struct MainView: View {
    
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("systemThemeEnabled") private var systemThemeEnabled  = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    SFSymbols.newsIcon
                    Text("News")
                }
            
            SettingsView(darkModeEnabled: $darkModeEnabled, systemThemeEnabled: $systemThemeEnabled)
                .tabItem {
                    SFSymbols.settings
                    Text("Settings")
                }
        }
        .onAppear {
            SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
        }
        .fullScreenCover(isPresented: .constant(!hasSeenOnboarding), content: {
            let plistManager = PlistManagerImpl()
            let onBoardingContentManager = OnboardingContentManagerImpl(manager: plistManager)
            OnboardingScreenViewq(manager: onBoardingContentManager) {
                hasSeenOnboarding = true
            }
        })
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

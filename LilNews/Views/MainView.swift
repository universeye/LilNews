//
//  HomeView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/8.
//
///Bugs -
///fix reloading everytime after entering settings
///refactor scrollView
///error screen & onboarding button tint color to match
//////////

import SwiftUI

struct MainView: View {
    
    
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @AppStorage("systemThemeEnabled") private var systemThemeEnabled  = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    
    @State private var animate: Bool = false
    @State private var showSplash: Bool = true
    
    var body: some View {
        ZStack {
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
            .accentColor(Theme.tintColor)
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
            
            introSplashScreen(animate: $animate, showSplash: $showSplash)
            
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animate.toggle()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                showSplash.toggle()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

struct introSplashScreen: View {
    
    let color = UIColor(red: 123/255, green: 216/255, blue: 160/255, alpha: 1)
    @Binding var animate: Bool
    @Binding var showSplash: Bool
    
    var body: some View {
        ZStack {
            Color(color).ignoresSafeArea()
            Image("newsicon1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 85, height: 85)
                .scaleEffect(animate ? 50 : 1)
                .opacity(animate ? 0.0 : 1)
                .animation(Animation.spring())
            
        }
        .opacity(showSplash ? 1 : 0)
        .animation(Animation.easeOut(duration: 0.8))
    }
}

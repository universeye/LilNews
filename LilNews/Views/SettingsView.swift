//
//  SettingsView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/8.
//

import SwiftUI

struct SettingsView: View {
    
    
    @Binding var darkModeEnabled: Bool
    @Binding var systemThemeEnabled: Bool
    
    @State var isShowOnboarding = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Display"), footer: Text("System settings will override Dark mode and use the current device theme")) {
                    Toggle(isOn: $darkModeEnabled, label: {
                        Text("Dark Mode")
                    })
                    .onChange(of: darkModeEnabled, perform: { _ in
                        SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
                    })
                    Toggle(isOn: $systemThemeEnabled, label: {
                        Text("Use system settings")
                    })
                    .onChange(of: systemThemeEnabled, perform: { _ in
                        SystemThemeManager.shared.handleTheme(darkMode: darkModeEnabled, system: systemThemeEnabled)
                    })
                }
                
                
                Section {
                    Link(destination: URL(string: Constants.twitter)!, label: {
                        
                        HStack(spacing: 15) {
                            Image("twitterlogo")
                                .renderingMode(.template)
                                .resizable().aspectRatio(contentMode: .fit)
                                .frame(width: 22, height: 22)
                            Text("Follow me on Twitter @Argonyoyo")
                        }
                    })
                    
                    Link(destination: URL(string: Constants.email)!, label: {
                        Label("Contact me via Email", systemImage: "envelope.fill")
                    })
                    
                    Link(destination: URL(string: Constants.phone)!, label: {
                        Label("Contact me via phone call", systemImage: "phone.fill")
                    })
                    
                }
                .foregroundColor(Theme.textColor)
                .font(.system(size: 16, weight: .semibold))
                
                Section(header: Text("Developer")) {
                    Button(action: {
                        isShowOnboarding = true
                    }, label: {
                        Text("Show onboarding screen")
                    })
                }
                
            }
            .navigationTitle("Settings")
        }
        .fullScreenCover(isPresented: $isShowOnboarding, content: {
            let plistManager = PlistManagerImpl()
            let onBoardingContentManager = OnboardingContentManagerImpl(manager: plistManager)
            OnboardingScreenViewq(manager: onBoardingContentManager) {
                isShowOnboarding = false
            }
        })
    }

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(false))
    }
}

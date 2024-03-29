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
    
    @State private var isShowOnboarding = false
    @State private var isShowErrorView = false
    @State var appVersion = ""
    var body: some View {
        NavigationView {
            VStack {
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
                            
                            HStack(spacing: 20) {
                                Image("twitterlogo2")
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 18, height: 18)
                                    .padding(.leading, 3.5)
                                    .foregroundColor(Theme.textColor)
                                Text("Contact me on X")
                                    .foregroundColor(Theme.textColor)
                                Spacer()
                                Text("@yoyokuo")
                                
                            }
                        })
                        
                        Link(destination: URL(string: Constants.email)!, label: {
                            Label("Contact me via Email", systemImage: "envelope.fill")
                        })
                        .foregroundColor(Theme.textColor)
                        
                    }
                    
                    .font(.system(size: 16, weight: .semibold))
                    
                    Section(header: Text("Developer")) {
                        
                        Button(action: {
                            isShowOnboarding = true
                        }, label: {
                            Text("Show onboarding screen")
                        })
                        Button(action: {
                        }, label: {
                            HStack {
                                Text("App Version")
                                    .foregroundColor(Theme.textColor)
                                
                                Spacer()
                                
                                Text("\(appVersion)")
                                    .font(.system(size: 17, weight: .semibold))
                                    .foregroundColor(Theme.textColor)
                                    .padding(.horizontal)
                            }
                            
                        })
                    }
                    
                }
                .navigationTitle("Settings")
                Text("Copyright © 2021 @Universeye. All rights reserved.")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top, 6)
                    .padding(.bottom, 8)
                    .foregroundColor(Color.secondary)
                    .onAppear {
                        self.appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
                    }
            }
            .background(Color("ColorBackground").edgesIgnoringSafeArea(.all))
        }
        .fullScreenCover(isPresented: $isShowOnboarding, content: {
            let plistManager = PlistManagerImpl()
            let onBoardingContentManager = OnboardingContentManagerImpl(manager: plistManager)
            OnboardingScreenViewq(manager: onBoardingContentManager) {
                isShowOnboarding = false
            }
        })
        .fullScreenCover(isPresented: $isShowErrorView, content: {
            ErrorView(error: APIError.decodingEror, handler: {
                isShowErrorView = false
            })
        })
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(darkModeEnabled: .constant(false), systemThemeEnabled: .constant(false))
    }
}


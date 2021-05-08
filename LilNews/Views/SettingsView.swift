//
//  SettingsView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/8.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Display"), footer: Text("System settings will override Dark mode and use the current device theme")) {
                    Toggle(isOn: .constant(true), label: {
                        Text("Dark Mode")
                    })
                    Toggle(isOn: .constant(true), label: {
                        Text("Use system settings")
                    })
                }
                
                Section {
                    Label("Follow me on twitter @Argonyoyo", systemImage: "link")
                }
                .foregroundColor(.black)
                .font(.system(size: 16, weight: .semibold))
                
                
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

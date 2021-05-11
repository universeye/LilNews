//
//  SystemThemeManager.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/10.
//

import Foundation
import UIKit

class SystemThemeManager {
    static let shared = SystemThemeManager()
    
    private init() {}
    
    func handleTheme(darkMode: Bool, system: Bool) {
        
        guard !system else { //if the system is false, carry on
            UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .unspecified
            return
        }
        
        
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
}

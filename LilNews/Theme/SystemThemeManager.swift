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
            
//            UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = .unspecified
            return
        }
        
        
        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = darkMode ? .dark : .light
//        UIApplication.shared.keyWindow?.overrideUserInterfaceStyle = darkMode ? .dark : .light
    }
}

extension UIApplication {
    
    var keyWindow: UIWindow? {
        // Get connected scenes
        return UIApplication.shared.connectedScenes
            // Keep only active scenes, onscreen and visible to the user
            .filter { $0.activationState == .foregroundActive }
            // Keep only the first `UIWindowScene`
            .first(where: { $0 is UIWindowScene })
            // Get its associated windows
            .flatMap({ $0 as? UIWindowScene })?.windows
            // Finally, keep only the key window
            .first(where: \.isKeyWindow)
    }
    
}

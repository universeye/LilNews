//
//  OnboardingContentManager.swift
//  TundsdevOnboarding
//
//  Created by Terry Kuo on 2021/5/10.
//

import Foundation

protocol OnboardingContentManager {
    var limit: Int { get }
    var items: [OnboardingItem] { get }
    init (manager: PlistManager)
}

final class OnboardingContentManagerImpl: OnboardingContentManager {
    var limit: Int {
        items.count - 1
    }
    
    var items: [OnboardingItem]
    
    init(manager: PlistManager) {
        print("Initializing OnboardingContentManagerImpl")
        self.items = manager.convert(plist: "OnboardingContentPlist")
    }
    
    
}

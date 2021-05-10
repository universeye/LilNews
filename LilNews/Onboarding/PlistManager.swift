//
//  PlistManager.swift
//  TundsdevOnboarding
//
//  Created by Terry Kuo on 2021/5/6.
//

import Foundation

protocol PlistManager {
    func convert(plist filename: String) -> [OnboardingItem]
}

struct PlistManagerImpl: PlistManager {
    func convert(plist filename: String) -> [OnboardingItem] {
        print("converting.....")
        guard let url = Bundle.main.url(forResource: filename, withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let item = try? PropertyListDecoder().decode([OnboardingItem].self, from: data) else {
            return []
        }
        print("item: \(item)")
        return item
    }
}

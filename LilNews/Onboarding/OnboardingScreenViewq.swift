//
//  OnboardingScreenViewq.swift
//  TundsdevOnboarding
//
//  Created by Terry Kuo on 2021/5/5.
//

import SwiftUI

struct OnboardingScreenViewq: View {
   
    private let manager: OnboardingContentManager
    private let handler: OnboardingAction
    @State private var selected = 0
    
    init(manager: OnboardingContentManager, handler: @escaping OnboardingAction) {
        self.manager = manager
        self.handler = handler
    }
    
    var body: some View {
        TabView(selection: $selected) {
            ForEach(manager.items.indices) { index in
                OnboardingCardView(item: manager.items[index], limit: manager.limit, index: $selected, handler: handler)
            }
        }
        
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        
    }
}

struct OnboardingScreenViewq_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingScreenViewq(manager: OnboardingContentManagerImpl(manager: PlistManagerImpl())) {}
            .preferredColorScheme(.light)
    }
}

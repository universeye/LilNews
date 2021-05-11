//
//  OnboardingVew.swift
//  TundsdevOnboarding
//
//  Created by Terry Kuo on 2021/5/5.
//

import SwiftUI

typealias OnboardingAction = () -> Void


struct OnboardingCardView: View {
    
    private let item: OnboardingItem
    
    private let limit: Int
    private let handler: OnboardingAction
    @Binding var index: Int
    
    @Environment(\.presentationMode) private var presentationMode
    
    init(item: OnboardingItem, limit: Int, index: Binding<Int>, handler: @escaping OnboardingAction) {
        self.item = item
        self.limit = limit
        self._index = index
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(systemName: item.sfSymbol ?? "")
                .padding(.bottom, 50)
                .font(.system(size: 120, weight: .bold))
            
            Text(item.title ?? "")
                .font(.system(size: 32, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 2)
                .foregroundColor(Theme.textColor)
            
            Text(item.content ?? "")
                .font(.system(size: 12, weight: .regular))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
                .foregroundColor(.gray)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
                handler()
            }, label: {
                Text("Get Started")
            })
            .font(.system(size: 18, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 15)
            .padding(.vertical, 10)
            .background(Color.blue)
            .clipShape(Capsule())
            .padding(.top, 50)
            .opacity(index == limit ? 1 : 0)
            .allowsHitTesting(index == limit)
            .animation(.easeInOut(duration: 0.25))
            
        }
        .padding(.bottom, 150)
    }
}

struct OnboardingVew_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingCardView(item: OnboardingItem(title: "Dummy", content: "Dummy Content", sfSymbol: "heart"), limit: 0, index: .constant(0)) {}
    }
}

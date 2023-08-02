//
//  ErrorView.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/24.
//

import SwiftUI

struct ErrorView: View {
   
    
    
    let error: Error
    typealias ErrorViewActionHandler = () -> Void
    let handler: ErrorViewActionHandler
    
    internal init(error: Error,
                  handler: @escaping ErrorView.ErrorViewActionHandler) {
        self.error = error
        self.handler = handler
    }
    
    var body: some View {
        VStack {
            SFSymbols.error
                .foregroundColor(.gray)
                .font(.system(size: 50, weight: .heavy))
                .padding(.bottom, 4)
            Text("Ooopss")
                .foregroundColor(Theme.textColor)
                .font(.system(size: 30, weight: .heavy))
                .multilineTextAlignment(.center)
            
            Text(error.localizedDescription)
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
                .padding(.vertical, 4)
            
            Button(action: {
                handler()
            }, label: {
                Text("Retry")
            })
            .padding(.vertical, 12)
            .padding(.horizontal, 30)
            .background(Theme.tintColor, alignment: .center)
            .foregroundColor(.white)
            .font(.system(size: 15, weight: .heavy))
            .cornerRadius(10)
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(error: APIError.decodingEror, handler: {}).previewLayout(.sizeThatFits)
    }
}

//
//  ResultState.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation

enum ResultState: Equatable {
    
    
    case loading
    case success(content: [NewsResponse.Articles])
    case failed(error: Error)
    
    
    static func == (lhs: ResultState, rhs: ResultState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
            
        case (.failed(error: let lhsType), .failed(error: let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.success(content: let lhsType), .success(content: let rhsType)):
            return lhsType == rhsType
        default :
            return false
            
            
            
            
            
            
        }
    }
}

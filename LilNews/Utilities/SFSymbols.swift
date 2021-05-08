//
//  SFSymbols.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/5/8.
//

import Foundation
import SwiftUI

enum SFSymbols: String, View {
    
    case settings = "gearshape"
    case warning = "exclamationmark.triangle.fill"
    case placeholderImage = "photo.fill"
    case error = "exclamationmark.icloud.fill"
    case newsIcon = "newspaper"
    
    
    var body: some View {
        Image(systemName: self.rawValue)
    }
}

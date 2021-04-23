//
//  ResultState.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation

enum ResultState {
    case loading
    case success(content: [NewsResponse.Articles])
    case failed(error: Error)
}

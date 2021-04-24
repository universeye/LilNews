//
//  APIError.swift
//  LilNews
//
//  Created by Terry Kuo on 2021/4/23.
//

import Foundation

 enum APIError: Error {
    case error(_ errorString: String)
    case decodingEror
    case errorCode(Int)
    case unknown
}


extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingEror:
            return "Failed to decode the object from the service"
        case .errorCode(let code):
            return "\(code) - Something went wrong!"
        case .unknown:
            return "The error is unknown"
        case .error(_):
            return "Error happened"
        }
    }
}

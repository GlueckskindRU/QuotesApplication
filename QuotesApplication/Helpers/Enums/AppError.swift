//
//  AppError.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.12.2021.
//

import Foundation

enum AppError: Error {
    case notFoundData
    case networkError(ErrorResponse)
    case otherError(Error)
    
    var localizedDescription: String {
        get {
            switch self {
                case .notFoundData:
                    return "notFoundData.Error"
                case .networkError(let response):
                    return "Network error with status code \(response.statusCode): <\(response.statusMessage)>"
                case .otherError(let error):
                    return error.localizedDescription
            }
        }
    }
}

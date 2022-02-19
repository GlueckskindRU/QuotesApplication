//
//  AppError.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.12.2021.
//

import Foundation

enum AppError: Error {
    case notFoundData
    case otherError(Error)
    
    var localizedDescription: String {
        get {
            switch self {
                case .notFoundData:
                    return "notFoundData.Error"
                case .otherError(let error):
                    return error.localizedDescription
            }
        }
    }
}

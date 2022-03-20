//
//  AppError.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.12.2021.
//

import Foundation

enum AppError: Error {
    case notFoundData
    case notDecoded(Decodable)
    case otherError(Error)
    
    var localizedDescription: String {
        get {
            switch self {
                case .notFoundData:
                    return "notFoundData.Error"
                case .notDecoded(let sourse):
                    return "received instance of type <\(type(of: sourse))> was not decoded"
                case .otherError(let error):
                    return error.localizedDescription
            }
        }
    }
}

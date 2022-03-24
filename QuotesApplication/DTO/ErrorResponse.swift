//
//  ErrorResponse.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.03.2022.
//

import Foundation

struct ErrorResponse: Codable {
    let statusCode: Int
    let statusMessage: String
}

//
//  Quote.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Foundation
// MARK: - Quote
struct Quote: Codable {
    let id: String
    let tags: [String]
    let content, author, authorSlug: String
    let length: Int
    let dateAdded, dateModified: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case tags, content, author, authorSlug, length, dateAdded, dateModified
    }
}

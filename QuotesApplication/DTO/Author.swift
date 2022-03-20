//
//  Author.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Foundation
// MARK: - Author
struct Author: Codable {
    let link: String
    let bio, authorDescription, id, name: String
    let quoteCount: Int
    let slug, dateAdded, dateModified: String
//    let quotes: [Quote]

    enum CodingKeys: String, CodingKey {
        case link, bio
        case authorDescription = "description"
        case id = "_id"
        case name, quoteCount, slug, dateAdded, dateModified
//        case quotes
    }
}

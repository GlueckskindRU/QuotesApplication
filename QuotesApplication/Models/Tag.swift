//
//  Tag.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Foundation
// MARK: - Tag
struct Tag: Codable {
    let id, name, dateAdded, dateModified: String
    let v, quoteCount: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, dateAdded, dateModified
        case v = "__v"
        case quoteCount
    }
}

typealias Tags = [Tag]

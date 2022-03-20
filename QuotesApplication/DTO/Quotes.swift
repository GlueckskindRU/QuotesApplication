//
//  Quotes.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Foundation

struct Quotes: Codable {
    let count, totalCount, page, totalPages: Int
    let lastItemIndex: Int
    let results: [Quote]
}

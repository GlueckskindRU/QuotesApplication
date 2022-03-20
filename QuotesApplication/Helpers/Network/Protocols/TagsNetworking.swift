//
//  TagsNetworking.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Foundation

protocol TagsNetworking {
    func getTags(completion: @escaping (Result<Tags, Error>) -> Void)
}

//
//  AuthorNetworking.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Foundation

protocol AuthorNetworking {
    func getAuthors(completion: @escaping (Result<Authors, Error>) -> Void)
    func getAutthorsByPage(page: Int, completion: @escaping (Result<Authors, Error>) -> Void)
    func getAuthorByID(id: String, completion: @escaping (Result<Author, Error>) -> Void)
    func getAuthorBySlug(slug: [String], completion: @escaping (Result<Author, Error>) -> Void)
}

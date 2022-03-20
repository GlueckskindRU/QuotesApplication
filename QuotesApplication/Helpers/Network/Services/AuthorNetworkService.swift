//
//  AuthorNetworkService.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Moya

extension AuthorNetworkService {
    struct Dependencies {
        let networkService: MoyaProvider<NetworkService>
    }
}

class AuthorNetworkService {
    private let deps: Dependencies
    
    init(deps: Dependencies) {
        self.deps = deps
    }
}

extension AuthorNetworkService: AuthorNetworking {
    func getAuthors(completion: @escaping (Result<Authors, Error>) -> Void) {
        deps.networkService.apiRequest(.getAuthors, completion: completion)
    }
    
    func getAuthorByID(id: String, completion: @escaping (Result<Author, Error>) -> Void) {
        deps.networkService.apiRequest(.getAuthorByID(id: id), completion: completion)
    }
    
    func getAuthorBySlug(slug: [String], completion: @escaping (Result<Author, Error>) -> Void) {
        deps.networkService.apiRequest(.getAuthorBySlug(slug: slug), completion: completion)
    }
}

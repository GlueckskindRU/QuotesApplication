//
//  QuoteNetworkService.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Moya

extension QuoteNetworkService {
    struct Dependencies {
        let networkService: MoyaProvider<NetworkService>
    }
}

class QuoteNetworkService {
    private let deps: Dependencies
    
    init(deps: Dependencies) {
        self.deps = deps
    }
}

extension QuoteNetworkService: QuoteNetworking {
    func getRandomQuote(completion: @escaping (Result<Quote, Error>) -> Void) {
        deps.networkService.apiRequest(.getRandomQuote, completion: completion)
    }
    
    func getQuotes(page: Int?, tags: [String]?, logic: UnionLogic?, author: String?, completion: @escaping (Result<Quotes, Error>) -> Void) {
        deps.networkService.apiRequest(.getQuotes(page: page, tags: tags, logic: logic, author: author), completion: completion)
    }
    
    func getQuote(id: String, completion: @escaping (Result<Quote, Error>) -> Void) {
        deps.networkService.apiRequest(.getQuote(id: id), completion: completion)
    }
}

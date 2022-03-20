//
//  TagsNetworkService.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Moya

extension TagsNetworkService {
    struct Dependencies {
        let networkService: MoyaProvider<NetworkService>
    }
}

class TagsNetworkService {
    private let deps: Dependencies
    
    init(deps: Dependencies) {
        self.deps = deps
    }
}

extension TagsNetworkService: TagsNetworking {
    func getTags(completion: @escaping (Result<Tags, Error>) -> Void) {
        deps.networkService.apiRequest(.getTags, completion: completion)
    }
}

//
//  MoyaProvider+Custom.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Moya

extension MoyaProvider {
    func apiRequest<T: Decodable>(_ target: Target, completion: @escaping (Result<T, Error>) -> Void) {
        request(target) { result in
            switch result {
                case .success(let response):
                    if let decodedResult = try? response.map(T.self) {
                        completion(.success(decodedResult))
                    } else {
                        completion(.failure(AppError.notDecoded(T.self as! Decodable)))
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

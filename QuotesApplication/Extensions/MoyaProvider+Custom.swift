//
//  MoyaProvider+Custom.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Moya

extension MoyaProvider {
    func apiRequest<T: Decodable>(_ target: Target, completion: @escaping (Result<T, AppError>) -> Void) {
        request(target) { result in
            switch result {
                case let .success(response):
//                    print("🏳️‍🌈 url = \(String(describing: response.request?.url?.absoluteString))")
//                    print("🚩 status code = \(response.statusCode)")
//                    let data = response.data
//                    let decodedDataString = String(data: data, encoding: .utf8)
//                    print("decodedDataString = <\(String(describing: decodedDataString))>")

                    do {
                        let decodedResult = try response.map(T.self)
                        completion(.success(decodedResult))
                    } catch {
                        completion(.failure(AppError.otherError(error)))
                    }
                case let .failure(error):
                    do {
                        guard let errorResponse = error.response else {
                            return completion(.failure(AppError.otherError(error)))
                        }
                        let decodedErrorResponse = try errorResponse.map(ErrorResponse.self)
                        completion(
                            .failure(AppError.networkError(decodedErrorResponse))
                        )
                    } catch {
                        completion(.failure(AppError.otherError(error)))
                    }
            }
        }
    }
}

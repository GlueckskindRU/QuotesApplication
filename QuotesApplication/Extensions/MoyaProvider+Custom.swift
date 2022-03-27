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
//                    print("🏳️‍🌈 url = \(String(describing: response.request?.url?.absoluteString))")
//                    print("🚩 status code = \(response.statusCode)")
//                    let data = response.data
//                    let decodedDataString = String(data: data, encoding: .utf8)
//                    print("decodedDataString = <\(String(describing: decodedDataString))>")

                    if response.statusCode >= 400 {
                        do {
                            let decodedErrorResponse = try response.map(ErrorResponse.self)
                            completion(
                                .failure(AppError.networkError(decodedErrorResponse))
                            )
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        do {
                            let decodedResult = try response.map(T.self)
                            completion(.success(decodedResult))
                        } catch {
                            completion(.failure(error))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

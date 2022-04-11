//
//  QuoteNetworking.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 16.03.2022.
//

import Foundation

protocol QuoteNetworking {
    func getRandomQuote(completion: @escaping (Result<Quote, AppError>) -> Void)
    func getQuotes(page: Int?, tags: [String]?, logic: UnionLogic?, author: String?, completion: @escaping (Result<Quotes, AppError>) -> Void)
    func getQuote(id: String, completion: @escaping (Result<Quote, AppError>) -> Void)
}

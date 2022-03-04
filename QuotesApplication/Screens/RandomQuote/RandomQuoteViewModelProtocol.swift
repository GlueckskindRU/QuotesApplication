//
//  RandomQuoteViewModelProtocol.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import Foundation

protocol RandomQuoteViewModelProtocol: AnyObject {
    var bindAuthor: ((String) -> Void)? { get set }
    var bindQuoteText: ((String) -> Void)? { get set }
    var tagsArray: [String] { get }
    
    func fetchRandomQuote(_ completion: @escaping () -> Void)
}

//
//  RandomQuoteViewModel.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Foundation

extension RandomQuoteViewModel {
    struct Dependencies {
        let networkService: QuoteNetworking
    }
}

class RandomQuoteViewModel {
    private let deps: Dependencies
    
    init(deps: Dependencies) {
        self.deps = deps
    }
    
    var bindTags: (([String]) -> Void)?
    var bindAuthor: ((String) -> Void)?
    var bindQuoteText: ((String) -> Void)?
    var tagsArray: [String] = []
}

extension RandomQuoteViewModel: RandomQuoteViewModelProtocol {
    func fetchRandomQuote(_ completion: @escaping () -> Void) {
        deps.networkService.getRandomQuote { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let randomQuote):
                    self.bindQuoteText?(randomQuote.content)
                    self.bindTags?(randomQuote.tags)
                    self.tagsArray = randomQuote.tags
                    self.bindAuthor?(randomQuote.author)
                    completion()
                case .failure(let error):
                    print("2. ERROR: \(error.localizedDescription)")
            }
        }
    }
}

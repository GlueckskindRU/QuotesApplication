//
//  RandomQuoteViewModel.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Moya

class RandomQuoteViewModel: RandomQuoteViewModelProtocol {
    private var networkService = MoyaProvider<NetworkService>()
    
    var bindTags: (([String]) -> Void)?
    var bindAuthor: ((String) -> Void)?
    var bindQuoteText: ((String) -> Void)?
    var tagsArray: [String] = []
    
    func fetchRandomQuote(_ completion: @escaping () -> Void) {
        networkService.request(.getRandomQuote) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let response):
                    if let randomQuote = try? response.map(Quote.self) {
                        print("QUOTE = <\(randomQuote)>")
                        self.bindQuoteText?(randomQuote.content)
                        self.bindTags?(randomQuote.tags)
                        self.tagsArray = randomQuote.tags
                        self.bindAuthor?(randomQuote.author)
                        completion()
                    } else {
                        print("1. ERROR WHILE CONVERSION")
                    }
                case .failure(let error):
                    print("2. ERROR: \(error.localizedDescription)")
            }
        }
    }
}

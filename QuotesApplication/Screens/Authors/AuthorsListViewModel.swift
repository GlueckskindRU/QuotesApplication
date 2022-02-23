//
//  AuthorsListViewModel.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 21.02.2022.
//

import Moya

protocol AuthorsListViewModelProtocol {
    var title: String { get }
    var authorsCount: Int { get }
    
    func fetchAuthors(_ completion: @escaping () -> Void)
    func cellViewModel(for row: Int) -> AuthorsListViewModel.CellViewModel
}

extension AuthorsListViewModel {
    struct CellViewModel {
        let authorName: String
        let authorDescription: String
        let quotesCount: String
    }
}

class AuthorsListViewModel: AuthorsListViewModelProtocol {
    private var networkService = MoyaProvider<NetworkService>()
    private var authors: Authors?
    
    private(set) var title: String
    
    var authorsCount: Int {
        return authors?.results.count ?? 0
    }
    
    init(title: String) {
        self.title = title
    }
    
    func fetchAuthors(_ completion: @escaping () -> Void) {
        networkService.request(.getAuthors) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
                case .success(let response):
                    if let authors = try? response.map(Authors.self) {
                        self.authors = authors
                        completion()
                    } else {
                        print("1. ERROR WHILE CONVERSION")
                    }
                case .failure(let error):
                    print("2. ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func cellViewModel(for row: Int) -> CellViewModel {
        guard let author = authors?.results[row] else {
            fatalError("Incorrect row index for Authors: <\(row)>")
        }
        
        return CellViewModel(
            authorName: author.name,
            authorDescription: author.authorDescription,
            quotesCount: "\(author.quoteCount)"
        )
    }
}

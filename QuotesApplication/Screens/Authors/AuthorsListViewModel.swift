//
//  AuthorsListViewModel.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 21.02.2022.
//

import Foundation

extension AuthorsListViewModel {
    struct Context {
        let title: String
    }
    
    struct Dependencies {
        let networkService: AuthorNetworking
    }
    
    struct CellViewModel {
        let authorName: String
        let authorDescription: String
        let quotesCount: String
    }
}

class AuthorsListViewModel {
    private let context: Context
    private let deps: Dependencies
    
    private var authors: Authors?
    
    init(context: Context, deps: Dependencies) {
        self.context = context
        self.deps = deps
    }
}

extension AuthorsListViewModel: AuthorsListViewModelProtocol {
    var title: String { context.title }
    
    var authorsCount: Int { authors?.results.count ?? 0 }
    
    func fetchAuthors(_ completion: @escaping () -> Void) {
        deps.networkService.getAuthors { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                case .success(let authors):
                    self.authors = authors
                    completion()
                case .failure(let error):
                    print("2. ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func cellViewModel(for row: Int) -> CellViewModel {
        guard let author = authors?.results[row] else {
            return CellViewModel(
                authorName: "",
                authorDescription: "",
                quotesCount: ""
            )
        }
        
        return CellViewModel(
            authorName: author.name,
            authorDescription: author.authorDescription,
            quotesCount: "\(author.quoteCount)"
        )
    }
}

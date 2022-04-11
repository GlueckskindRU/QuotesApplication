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
}

class AuthorsListViewModel {
    private let context: Context
    private let deps: Dependencies
    
    private var authors: Authors? {
        didSet {
            didFetchAuthorsList?()
        }
    }
    private var fetchedAuthors: [Author] = []
    private var currentPage = 0
    
    var didFetchAuthorsList: (() -> Void)?
    var isMoreDataLoading = false
    
    init(context: Context, deps: Dependencies) {
        self.context = context
        self.deps = deps
    }
}

extension AuthorsListViewModel: AuthorsListViewModelProtocol {
    var title: String { context.title }
    
    var authorsCount: Int { fetchedAuthors.count }
    
    var isLastPageReached: Bool {
        guard
            let authors = authors,
            !fetchedAuthors.isEmpty
        else { return false }
        
        return authors.lastItemIndex == nil
    }
    
    func fetchAuthors() {
        currentPage += 1
        deps.networkService.getAutthorsByPage(page: currentPage) { [weak self] result in
            guard let self = self else { return }

            switch result {
                case let .success(authors):
                    self.fetchedAuthors.append(contentsOf: authors.results)
                    self.authors = authors
                    self.isMoreDataLoading = false
                case let .failure(error):
                    print("🌈 2. ERROR: \(error.localizedDescription)")
            }
        }
    }
    
    func cellViewModel(for row: Int) -> AuthorsListCellViewModel {
        guard fetchedAuthors.count > row else {
            return AuthorsListCellViewModel(
                authorName: "",
                authorDescription: "",
                quotesCount: ""
            )
        }
        
        return AuthorsListCellViewModel(
            authorName: fetchedAuthors[row].name,
            authorDescription: fetchedAuthors[row].authorDescription,
            quotesCount: String(describing: fetchedAuthors[row].quoteCount)
        )
    }
}

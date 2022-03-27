//
//  AuthorsListViewModelProtocol.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import Foundation

protocol AuthorsListViewModelProtocol {
//    associatedtype CellType
    
    var title: String { get }
    var authorsCount: Int { get }
    var isLastPageReached: Bool { get }
    var isMoreDataLoading: Bool { get set }
    var didFetchAuthorsList: (() -> Void)? { get set }
    
    func fetchAuthors()
    func cellViewModel(for row: Int) -> AuthorsListCellViewModel
}

//
//  AuthorsListViewModelProtocol.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import Foundation

protocol AuthorsListViewModelProtocol {
    var title: String { get }
    var authorsCount: Int { get }
    
    func fetchAuthors(_ completion: @escaping () -> Void)
    func cellViewModel(for row: Int) -> AuthorsListViewModel.CellViewModel
}

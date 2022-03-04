//
//  APIFilterViewModelProtocol.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import UIKit.UIViewController

protocol APIFilterViewModelProtocol {
    var apiFiltesCount: Int { get }
    
    func cellViewModel(for row: Int, from vc: UIViewController) -> APIFilterViewModel.CellViewModel
}

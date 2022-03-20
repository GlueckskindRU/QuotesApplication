//
//  APIFilterViewModel.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.02.2022.
//

import UIKit.UIViewController

extension APIFilterViewModel {
    enum APIFilters: Int, CaseIterable {
        case authors
        case quotes
        case tags
        
        var decription: String {
            switch self {
                case .authors:
                    return "List of Authors"
                case .quotes:
                    return "List of Quotes"
                case .tags:
                    return "List of Tags"
            }
        }
        
        var action: (UIViewController?) -> Void {
            switch self {
                case .authors:
                    return { parentVC in
                        let vc = AuthorsListAssembly.make(title: decription)
                        parentVC?.navigationController?.pushViewController(vc, animated: true)
                    }
                case .quotes:
                    return { _ in
                        print("HERE WILL BE THE ALL QUOTES LIST")
                    }
                case .tags:
                    return { _ in
                        print("HERE WILL BE THE ALL TAGS LIST")
                    }
            }
        }
    }
    
    struct CellViewModel {
        let title: String
        let buttonTapped: (UIViewController?) -> Void
        let parentVC: UIViewController
    }
}

class APIFilterViewModel: APIFilterViewModelProtocol {
    var apiFiltesCount: Int {
        return APIFilters.allCases.count
    }
    
    func cellViewModel(
        for row: Int,
        from vc: UIViewController
    ) -> CellViewModel {
        guard let apiFilter = APIFilters(rawValue: row) else {
            return CellViewModel(
                title: "",
                buttonTapped: { _ in return Void() },
                parentVC: vc
            )
        }

        return CellViewModel(
            title: apiFilter.decription,
            buttonTapped: apiFilter.action,
            parentVC: vc
        )
    }
}

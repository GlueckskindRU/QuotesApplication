//
//  AuthorsListAssembly.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import Foundation

final class AuthorsListAssembly {
    static func register() {
        let viewModel = AuthorsListViewModel()
        let viewController = AuthorsListTableViewController(viewModel: viewModel)
        ServiceLocator.shared.register(service: viewModel)
        ServiceLocator.shared.register(service: viewController)
    }
    
    static func make() -> AuthorsListTableViewController {
        guard
            let viewController: AuthorsListTableViewController = ServiceLocator.shared.resolve()
        else {
            fatalError("Some of AuthorsList servises is not registered before assembling!")
        }

        return viewController
    }
}

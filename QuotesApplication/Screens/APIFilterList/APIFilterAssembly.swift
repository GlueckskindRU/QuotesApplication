//
//  APIFilterAssembly.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 05.03.2022.
//

import Foundation

class APIFilterAssembly {
    static func register() {
        let viewModel = APIFilterViewModel()
        let viewController = APIFilterTableViewController(viewModel: viewModel)
        ServiceLocator.shared.register(service: viewModel)
        ServiceLocator.shared.register(service: viewController)
    }
    
    static func make() -> APIFilterTableViewController {
        guard
            let viewController: APIFilterTableViewController = ServiceLocator.shared.resolve()
        else {
            fatalError("Some of APIFilter servises is not registered before assembling!")
        }

        return viewController
    }
}

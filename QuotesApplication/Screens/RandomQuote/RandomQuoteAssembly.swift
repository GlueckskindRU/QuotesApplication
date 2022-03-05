//
//  RandomQuoteAssembly.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import Foundation

final class RandomQuoteAssembly {
    static func register() {
        let viewModel = RandomQuoteViewModel()
        let viewController = RandomQuoteViewConroller(viewModel: viewModel)
        ServiceLocator.shared.register(service: viewModel)
        ServiceLocator.shared.register(service: viewController)
    }
    
    static func make() -> RandomQuoteViewConroller {
        guard
            let viewController: RandomQuoteViewConroller = ServiceLocator.shared.resolve()
        else {
            fatalError("Some of RandomQoute servises is not registered before assembling!")
        }

        return viewController
    }
}

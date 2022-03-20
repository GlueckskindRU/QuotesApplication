//
//  RandomQuoteAssembly.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import UIKit

final class RandomQuoteAssembly {
    static func make() -> RandomQuoteViewConroller {
        let viewModel = (UIApplication.shared.delegate as! AppDelegate).container.resolve(RandomQuoteViewModelProtocol.self)!
        return RandomQuoteViewConroller(viewModel: viewModel)
    }
}

//
//  AuthorsListAssembly.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 04.03.2022.
//

import UIKit

final class AuthorsListAssembly {
    static func make(title: String) -> AuthorsListTableViewController {
        let viewModel = (UIApplication.shared.delegate as! AppDelegate).container.resolve(AuthorsListViewModelProtocol.self, argument: title)!
        return AuthorsListTableViewController(viewModel: viewModel)
    }
}

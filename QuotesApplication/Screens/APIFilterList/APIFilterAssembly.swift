//
//  APIFilterAssembly.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 05.03.2022.
//

import UIKit

class APIFilterAssembly {
    static func make() -> APIFilterTableViewController {
        let viewModel = (UIApplication.shared.delegate as! AppDelegate).container.resolve(APIFilterViewModelProtocol.self)!
        return APIFilterTableViewController(viewModel: viewModel)
    }
}

//
//  AuthorsListTableViewController.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 21.02.2022.
//

import UIKit
import SnapKit

class AuthorsListTableViewController: UIViewController {
    private var viewModel: AuthorsListViewModelProtocol
    
    init(viewModel: AuthorsListViewModelProtocol) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(AuthorsListCell.self, forCellReuseIdentifier: String(describing: AuthorsListCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        viewModel.fetchAuthors { [weak self] in
            self?.tableView.reloadData()
        }
        navigationItem.title = viewModel.title
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource

extension AuthorsListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.authorsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: AuthorsListCell.self), for: indexPath) as? AuthorsListCell else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.cellViewModel(for: indexPath.row)
        
        return cell
    }
}

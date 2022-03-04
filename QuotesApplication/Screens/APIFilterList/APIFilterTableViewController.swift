//
//  APIFilterTableViewController.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.02.2022.
//

import UIKit
import SnapKit

class APIFilterTableViewController: UIViewController {
    private var viewModel: APIFilterViewModelProtocol
    
    init(viewModel: APIFilterViewModelProtocol) {
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
        tableView.rowHeight = 44
        tableView.register(APIFilterCell.self, forCellReuseIdentifier: String(describing: APIFilterCell.self))
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARKL: - UITableViewDataSource

extension APIFilterTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.apiFiltesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: APIFilterCell.self),
                for: indexPath
            ) as? APIFilterCell
        else {
            return UITableViewCell()
        }
        
        cell.viewModel = viewModel.cellViewModel(for: indexPath.row, from: self)
        
        return cell
    }
}

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
    
    private var loadingMoreView:InfiniteScrollActivityView?
    lazy private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(
            AuthorsListCell.self,
            forCellReuseIdentifier: String(describing: AuthorsListCell.self)
        )
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        addSubviews()
        setupLayout()
        bindUIWithViewModel()
        setupActivityIndicator()
        
        navigationItem.title = viewModel.title
        viewModel.fetchAuthors()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func bindUIWithViewModel() {
        viewModel.didFetchAuthorsList = { [weak self] in
            guard let self = self else { return }
            self.loadingMoreView?.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    private func setupLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupActivityIndicator() {
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
    }
}

// MARK: - UITableViewDelegate

extension AuthorsListTableViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource

extension AuthorsListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.authorsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: String(describing: AuthorsListCell.self),
                for: indexPath) as? AuthorsListCell
        else { return UITableViewCell() }
        cell.viewModel = viewModel.cellViewModel(for: indexPath.row)
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension AuthorsListTableViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isNeededToIndicateActivityIndicator = !viewModel.isLastPageReached && !viewModel.isMoreDataLoading
        if isNeededToIndicateActivityIndicator {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > (scrollOffsetThreshold * 0.8) && tableView.isDragging) {
                viewModel.isMoreDataLoading = true
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView?.startAnimating()

                viewModel.fetchAuthors()
            }
        }
    }
}

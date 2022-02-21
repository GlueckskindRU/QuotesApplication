//
//  RandomQuoteViewConroller.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import UIKit

class RandomQuoteViewConroller: UIViewController {
    private var viewModel: RandomQuoteViewModelProtocol
    private var dataSource: RandomQuoteCollectionViewDataSource
    
    init(viewModel: RandomQuoteViewModelProtocol) {
        self.viewModel = viewModel
        self.dataSource = RandomQuoteCollectionViewDataSource(viewModel)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var quoteText: UILabel = {
        return UILabel.with(font: UIFont.systemFont(ofSize: 24, weight: .medium),
                            aligment: .justified,
                            color: .systemBlue,
                            lines: 0)
    }()
    
    lazy private var refreshButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setImage(UIImage(named: "refreshButton"), for: .normal)
        button.addTarget(self, action: #selector(refreshButtonWasTapped), for: .touchUpInside)
         
        return button
    }()
    
    lazy private var authorButton: UIButton = {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        
        return button
    }()
    
    lazy private var collectionView: UICollectionView = {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width - (2 * VisualConstants.offset), height: VisualConstants.collectionCellHeight)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumInteritemSpacing = 4
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TagCell.self, forCellWithReuseIdentifier: String(describing: TagCell.self))
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupLayout()
        
        viewModel.bindQuoteText = { [weak self] quoteText in
            guard let self = self else { return }
            self.quoteText.text = quoteText
        }
        viewModel.bindAuthor = { [weak self] author in
            guard let self = self else { return }
            self.authorButton.setTitle(author, for: .normal)
        }
        
        refreshButtonWasTapped()
    }
    
    @objc private func refreshButtonWasTapped() {
        viewModel.fetchRandomQuote{
            self.collectionView.reloadData()
        }
    }
    
    private func setupLayout() {
        view.addSubview(authorButton)
        view.addSubview(refreshButton)
        view.addSubview(quoteText)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            quoteText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: quoteText.trailingAnchor, constant: 16),
            
            collectionView.topAnchor.constraint(equalTo: quoteText.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: 16),
            collectionView.heightAnchor.constraint(equalToConstant: VisualConstants.collectionCellHeight),
            
            authorButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 16),
            authorButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            refreshButton.leadingAnchor.constraint(equalTo: authorButton.trailingAnchor, constant: 16),
            authorButton.heightAnchor.constraint(equalToConstant: 50),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: authorButton.bottomAnchor, constant: 16),
            
            refreshButton.centerYAnchor.constraint(equalTo: authorButton.centerYAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: refreshButton.trailingAnchor, constant: 8),
            refreshButton.widthAnchor.constraint(equalToConstant: 50),
            refreshButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

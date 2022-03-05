//
//  RandomQuoteViewConroller.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import UIKit
import SnapKit

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
         
        return button
    }()
    
    lazy private var menuButton: UIBarButtonItem = {
        return UIBarButtonItem(
            image: UIImage(named: "menuButton"),
            style: .plain,
            target: self,
            action: nil
        )
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
        
        addSubviews()
        setupLayout()
        addActions()
        bindUIWithViewModel()
        
        fetchRandomQuote()
    }
    
    private func addSubviews() {
        view.addSubview(authorButton)
        view.addSubview(refreshButton)
        view.addSubview(quoteText)
        view.addSubview(collectionView)
        
        navigationItem.rightBarButtonItem = menuButton
    }
    
    private func addActions() {
        refreshButton.addTarget(self, action: #selector(fetchRandomQuote), for: .touchUpInside)
        menuButton.action = #selector(menuButtonTapped)
    }
    
    private func bindUIWithViewModel() {
        viewModel.bindQuoteText = { [weak self] quoteText in
            guard let self = self else { return }
            self.quoteText.text = quoteText
        }
        
        viewModel.bindAuthor = { [weak self] author in
            guard let self = self else { return }
            self.authorButton.setTitle(author, for: .normal)
        }
    }
    
    @objc private func fetchRandomQuote() {
        viewModel.fetchRandomQuote{
            self.collectionView.reloadData()
        }
    }
    
    @objc private func menuButtonTapped() {
        let vc = APIFilterAssembly.make()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupLayout() {
        quoteText.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(quoteText.snp.bottomMargin).offset(16)
            $0.height.equalTo(VisualConstants.collectionCellHeight)
        }
        
        authorButton.snp.makeConstraints {
            $0.top.equalTo(collectionView.snp.bottomMargin).offset(16)
            $0.leading.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        refreshButton.snp.makeConstraints {
            $0.leading.equalTo(authorButton.snp.trailingMargin).offset(16)
            $0.centerY.equalTo(authorButton.snp.centerY)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(8)
            $0.height.width.equalTo(50)
        }
    }
}

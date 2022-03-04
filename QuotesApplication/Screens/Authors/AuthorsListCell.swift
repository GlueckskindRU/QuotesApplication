//
//  AuthorsListCell.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 21.02.2022.
//

import UIKit
import SnapKit

class AuthorsListCell: UITableViewCell {
    lazy private var authorNameLabel: UILabel = {
        return UILabel.with(
            font: UIFont.systemFont(ofSize: 20, weight: .regular),
            aligment: .left,
            color: .systemBlue,
            lines: 0
        )
    }()
    
    lazy private var authorDescriptionLabel: UILabel = {
        return UILabel.with(
            font: UIFont.systemFont(ofSize: 12, weight: .regular),
            aligment: .left,
            color: .systemBlue,
            lines: 0
        )
    }()
    
    lazy private var quotesCountLabel: UILabel = {
        return UILabel.with(
            font: UIFont.systemFont(ofSize: 24, weight: .medium),
            aligment: .center,
            color: .white,
            bgColor: .systemBlue,
            cornerRadius: 20
        )
    }()
    
    var viewModel: AuthorsListViewModel.CellViewModel? {
        didSet {
            authorNameLabel.text = viewModel?.authorName
            authorDescriptionLabel.text = viewModel?.authorDescription
            quotesCountLabel.text = viewModel?.quotesCount
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .clear
        
        addSubview()
        setupLayout()
    }
    
    private func addSubview() {
        contentView.addSubview(authorNameLabel)
        contentView.addSubview(authorDescriptionLabel)
        contentView.addSubview(quotesCountLabel)
    }
    
    private func setupLayout() {
        quotesCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(16)
            $0.height.width.equalTo(40)
            $0.top.bottom.equalToSuperview().inset(16)
        }
        
        authorNameLabel.snp.makeConstraints {
            $0.leading.equalTo(quotesCountLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(quotesCountLabel.snp.top)
        }
        
        authorDescriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(quotesCountLabel.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(authorNameLabel.snp.bottom).offset(8)
            $0.bottom.equalTo(quotesCountLabel.snp.bottom)
        }
    }
}

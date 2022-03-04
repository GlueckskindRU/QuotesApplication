//
//  APIFilterCell.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.02.2022.
//

import UIKit
import SnapKit

class APIFilterCell: UITableViewCell {
    lazy private var apiFiltersButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        return button
    }()
    
    var viewModel: APIFilterViewModel.CellViewModel? {
        didSet {
            apiFiltersButton.setTitle(viewModel?.title, for: .normal)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .clear
        addSubviews()
        setupLayout()
        addActions()
    }

    private func addSubviews() {
        contentView.addSubview(apiFiltersButton)
    }
    
    private func addActions() {
        apiFiltersButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        let verticalMargin: CGFloat = 4
        let horizontalMargin: CGFloat = 32
        
        apiFiltersButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(verticalMargin)
            $0.leading.trailing.equalToSuperview().inset(horizontalMargin)
        }
    }
    
    @objc private func buttonTapped() {
        viewModel?.buttonTapped(viewModel?.parentVC)
    }
}

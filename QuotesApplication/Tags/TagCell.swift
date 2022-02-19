//
//  TagCell.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import UIKit

class TagCell: UICollectionViewCell {
    lazy private var tagLabel: UILabel = {
        /*
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        
        return button
        */
        let label = UILabel.with(font: UIFont.systemFont(ofSize: 16, weight: .regular),
                                 aligment: .center,
                                 color: .white,
                                 lines: 0)
        
        label.backgroundColor = .systemBlue
        label.layer.cornerRadius = 16
        label.clipsToBounds = true
        return label
    }()
    
    private(set) var tagTitle: String = ""
    
    func configure(with title: String) {
        tagTitle = title
        tagLabel.text = title
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.backgroundColor = .clear
        contentView.addSubview(tagLabel)
        
        let margin: CGFloat = 2
        
        NSLayoutConstraint.activate([
            tagLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: margin),
            tagLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: margin),
            contentView.trailingAnchor.constraint(equalTo: tagLabel.trailingAnchor, constant: margin),
            contentView.bottomAnchor.constraint(equalTo: tagLabel.bottomAnchor, constant: margin * 4.0),
        ])
    }
}

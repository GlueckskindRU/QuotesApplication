//
//  UIButton.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import UIKit

extension UIButton {
    static func with(title: String, target: Any?, action: Selector, font: UIFont? = nil, color: UIColor? = nil) -> UIButton {
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitle(title, for: .normal)
        if let color = color {
            button.setTitleColor(color, for: .normal)
        }
        if let font = font {
            button.titleLabel?.font = font
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        
        return button
    }
}

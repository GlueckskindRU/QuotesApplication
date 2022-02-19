//
//  UILabel.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import UIKit

extension UILabel {
    static func with(font: UIFont, aligment: NSTextAlignment, color: UIColor, lines: Int = 0) -> UILabel {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = font
        label.textAlignment = aligment
        label.textColor = color
        label.numberOfLines = lines
        
        return label
    }
}

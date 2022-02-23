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
    
    static func with(
        font: UIFont,
        aligment: NSTextAlignment,
        color: UIColor,
        bgColor: UIColor,
        cornerRadius: CGFloat
    ) -> UILabel {
        let label = UILabel.with(
            font: font,
            aligment: aligment,
            color: color,
            lines: 0
        )
        label.backgroundColor = bgColor
        label.layer.cornerRadius = cornerRadius
        label.clipsToBounds = true
        return label
    }
}

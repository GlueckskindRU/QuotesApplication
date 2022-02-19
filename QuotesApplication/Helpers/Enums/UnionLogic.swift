//
//  UnionLogic.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 23.12.2021.
//

import Foundation

enum UnionLogic {
    case and
    case or
    
    var logicSymbol: String {
        switch self {
            case .and:
                return ","
            case .or:
                return "|"
        }
    }
}

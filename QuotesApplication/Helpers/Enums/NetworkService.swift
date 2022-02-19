//
//  NetworkService.swift
//  QuotesApplication
//
//  Created by Yuri Ivashin on 24.12.2021.
//

import Moya

enum NetworkService {
    case getRandomQuote
    case getAuthors
    case getAuthorByID(id: String)
    case getAuthorBySlug(slug: [String])
    case getQuotes(page: Int?, tags: [String]?, logic: UnionLogic?, author: String?)
    case getQuote(id: String)
    case getTags
}

extension NetworkService: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.quotable.io")!
    }
    
    var path: String {
        switch self {
            case .getRandomQuote:
                return "/random"
            case .getAuthors:
                return "/authors"
            case .getAuthorByID(let id):
                return "/authors/\(id)"
            case .getAuthorBySlug(let authorsSlugs):
                return "/authors?slug=\(authorsSlugs.joined(separator: UnionLogic.or.logicSymbol))"
            case .getQuotes(let page, let tags, let logic, let author):
                if let page = page {
                    return "/quotes?page=\(page)"
                }
                
                if let tags = tags {
                    if let logic = logic {
                        return "/quotes?tags=\(tags.joined(separator: logic.logicSymbol))"
                    }
                    
                    if let firstTag = tags.first {
                        return "/quotes?tags=\(firstTag)"
                    }
                }
                
                if let author = author {
                    return "/quotes?author=\(author)"
                }
                
                return "/quotes"
            case .getQuote(let id):
                return "/quotes\(id)"
            case .getTags:
                return "/tags?sortBy=name&order=asc"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}

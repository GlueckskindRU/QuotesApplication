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
    case getAuthorsByPage(page: Int)
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
            case .getAuthorsByPage(_):
                return "/authors"
            case .getAuthorByID(let id):
                return "/authors/\(id)"
            case .getAuthorBySlug(_):
                return "/authors"
            case .getQuotes(_, _, _, _):
                return "/quotes"
            case .getQuote(let id):
                return "/quotes\(id)"
            case .getTags:
                return "/tags"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        switch self {
            case .getAuthorsByPage(let page):
                return .requestParameters(
                    parameters: [
                        "page": page
                    ],
                    encoding: URLEncoding.default
                )
            case .getAuthorBySlug(let authorsSlugs):
                return .requestParameters(
                    parameters: [
                        "slug": authorsSlugs.joined(separator: UnionLogic.or.logicSymbol)
                    ],
                    encoding: URLEncoding.default
                )
            case .getTags:
                return .requestParameters(
                    parameters: [
                        "sortBy": "name",
                        "order": "asc"
                    ],
                    encoding: URLEncoding.default
                )
            case .getQuotes(let page, let tags, let logic, let author):
                if let page = page {
                    return .requestParameters(
                        parameters: [
                            "page": page
                        ],
                        encoding: URLEncoding.default
                    )
                }
                if let tags = tags {
                    if let logic = logic {
                        return .requestParameters(
                            parameters: [
                                "tags": tags.joined(separator: logic.logicSymbol)
                            ],
                            encoding: URLEncoding.default
                        )
                    }
                    if let firstTag = tags.first {
                        return .requestParameters(
                            parameters: [
                                "tags": firstTag
                            ],
                            encoding: URLEncoding.default
                        )
                    }
                }
                if let author = author {
                    return .requestParameters(
                        parameters: [
                            "author": author
                        ],
                        encoding: URLEncoding.default
                    )
                }
                return .requestPlain
            default:
                return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

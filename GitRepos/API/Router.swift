//
//  Router.swift
//  GitRepos
//
//  Created by Victor Magpali on 15/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import Alamofire
import Foundation

enum Router {
    case searchRepositories(languages: [String], sortBy: SortParameters, order: SortOrder, page: Int)
}

extension Router {
    
    var baseURL: String { "https://api.github.com/" }
    
    var url: URL {
        var urlString = baseURL
        urlString.append(contentsOf: path)
        urlString.append(contentsOf: queryString ?? "")
        
        guard let url = URL(string: urlString) else { fatalError("Watch out for typos!!!") }
        return url
    }
    
    var path: String {
        switch self {
        case .searchRepositories:
            return "search/repositories"
        }
    }
    
    var queryString: String? {
        switch self {
        case .searchRepositories(let languages, let sortBy, let order, let page):
            let languagesQuery = languages.joined(separator: "+")
            return "?q=languages:\(languagesQuery)&sort=\(sortBy)&order=\(order)&page=\(page)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .searchRepositories:
            return .get
        }
    }
    
    
}

//
//  RepositorySearchResult.swift
//  GitRepos
//
//  Created by Victor Magpali on 15/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//
import RxSwift

enum SortParameters: String {
    case stars
    case forks
    case helpWantedIssues = "help-wanted-issues"
    case updated
}

enum SortOrder: String {
    case ascending = "asc"
    case descending = "desc"
}

struct RepositorySearchResult: Codable {
    let totalCount: Int
    let items: [Repository]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        
        case items
    }
    
    static func searchForRepositories(in languages: [String],
                                      sortBy sortParams: SortParameters,
                                      order: SortOrder,
                                      page: Int,
                                      itemsPerPage: Int) -> Single<RepositorySearchResult> {
        let router = Router.searchRepositories(languages: languages,
                                               sortBy: sortParams,
                                               order: order,
                                               page: page,
                                               itemsPerPage: itemsPerPage)
        
        let request = RequestManager.request(with: router) as Single<RepositorySearchResult>
        return request
    }
}

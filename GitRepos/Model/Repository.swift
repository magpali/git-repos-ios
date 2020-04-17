//
//  Repository.swift
//  GitRepos
//
//  Created by Victor Magpali on 15/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String
    let watchers: Int
    let forks: Int
    let owner: Owner
}


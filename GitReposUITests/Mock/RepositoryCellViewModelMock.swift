//
//  RepositoriesViewModelMock.swift
//  GitReposUITests
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

@testable import GitRepos
import RxCocoa

class RepositoryCellViewModelMock: RepositoryCellViewModelProtocol {
    var avatarImageObservable = BehaviorRelay<UIImage>(value: UIImage())
    
    var ownerNameObservable = BehaviorRelay<String>(value: "Magpali")
    
    var repoNameObservable = BehaviorRelay<String>(value: "GitRepos")
    
    var repoDescriptionObservable = BehaviorRelay<String>(value: "The best app in the whoooooooooooole world!!! :)")
    
    var forksObservable = BehaviorRelay<String>(value: "42")
    
    var watchersObservable = BehaviorRelay<String>(value: "666")
    
    func fetchImage() {}
}

//
//  RepositoriesViewModel.swift
//  GitRepos
//
//  Created by Victor Magpali on 16/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol RepositoriesViewModelProtocol {
    var repositoryViewModels: BehaviorRelay<[RepositoryTableViewCellViewModel]> { get }
    var error: PublishRelay<Error> { get }
    var loading: PublishRelay<Bool> { get }
    var currentRow: PublishRelay<Int> { get }
    
    func refreshSearch()
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    var repositoryViewModels = BehaviorRelay<[RepositoryTableViewCellViewModel]>(value: [])
    var error = PublishRelay<Error>()
    var loading = PublishRelay<Bool>()
    var currentRow = PublishRelay<Int>()
    
    private var disposeBag = DisposeBag()
    
    init() {
    }
    
    func refreshSearch() {
        loading.accept(true)
        RepositorySearchResult.searchForRepositories(in: ["Swift"], sortBy: .stars, order: .ascending, page: 0).subscribe { [weak self] event in
            self?.loading.accept(false)
            switch event {
            case .success(let result):
                let viewModels = result.items.map { repository in
                    return RepositoryTableViewCellViewModel(repository: repository)
                }
                self?.repositoryViewModels.accept(viewModels)
            case .error(let error):
                self?.error.accept(error)
            }
        }.disposed(by: disposeBag)
    }
    
    
}

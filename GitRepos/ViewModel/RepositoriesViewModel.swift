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
    var items: BehaviorRelay<[Repository]> { get }
    var error: PublishRelay<Error> { get }
    var loading: PublishRelay<Bool> { get }
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    var items = BehaviorRelay<[Repository]>(value: [])
    var error = PublishRelay<Error>()
    var loading = PublishRelay<Bool>()
    
    private var disposeBag = DisposeBag()
    
    init() {
        refreshSearch()
    }
    
    func refreshSearch() {
        loading.accept(true)
        RepositorySearchResult.searchForRepositories(in: ["Swift"], sortBy: .stars, order: .ascending, page: 0).subscribe { [weak self] event in
            self?.loading.accept(false)
            switch event {
            case .success(let result):
                self?.items.accept(result.items)
            case .error(let error):
                self?.error.accept(error)
            }
        }.disposed(by: disposeBag)
    }
    
    
}

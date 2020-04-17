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
    var refreshing: BehaviorRelay<Bool> { get }
    var loading: BehaviorRelay<Bool> { get }
    var currentRow: PublishRelay<Int> { get }
    
    func refreshSearch()
}

class RepositoriesViewModel: RepositoriesViewModelProtocol {
    
    private let defaultItemsPerPage = 50
    private var currentPage = 1
    private var totalCount = 0
    
    var repositoryViewModels = BehaviorRelay<[RepositoryTableViewCellViewModel]>(value: [])
    var error = PublishRelay<Error>()
    var refreshing = BehaviorRelay<Bool>(value: false)
    var loading = BehaviorRelay<Bool>(value: false)
    var currentRow = PublishRelay<Int>()
    
    private var disposeBag = DisposeBag()
    
    init() {
        subscribeToChanges()
    }
    
    func refreshSearch() {
        refreshing.accept(true)
        currentPage = 1
        RepositorySearchResult.searchForRepositories(in: ["Swift"],
                                                     sortBy: .stars,
                                                     order: .descending,
                                                     page: currentPage,
                                                     itemsPerPage:  defaultItemsPerPage).subscribe { [weak self] event in
            self?.refreshing.accept(false)
            switch event {
            case .success(let result):
                self?.totalCount = result.totalCount
                let viewModels = result.items.map { repository in
                    return RepositoryTableViewCellViewModel(repository: repository)
                }
                self?.repositoryViewModels.accept(viewModels)
            case .error(let error):
                self?.error.accept(error)
            }
        }.disposed(by: disposeBag)
    }
    
    private func subscribeToChanges() {
        currentRow.subscribe(onNext: { [weak self] value in
            print("currentRow: \(value)")
            
            guard let strongSelf = self else { return }
            if value > strongSelf.repositoryViewModels.value.count - (strongSelf.defaultItemsPerPage / 2),
            strongSelf.repositoryViewModels.value.count < strongSelf.totalCount,
            strongSelf.loading.value == false {
                print("arrayCount: \(strongSelf.repositoryViewModels.value.count)")
                print("totalCount: \(strongSelf.totalCount)")
                
                strongSelf.getNextPage()
            }
        }).disposed(by: disposeBag)
    }
    
    private func getNextPage() {
        loading.accept(true)
        currentPage += 1
        RepositorySearchResult.searchForRepositories(in: ["Swift"],
                                                     sortBy: .stars,
                                                     order: .descending,
                                                     page: currentPage,
                                                     itemsPerPage:  defaultItemsPerPage).subscribe { [weak self] event in
            self?.loading.accept(false)
            switch event {
            case .success(let result):
                guard let strongSelf = self else { return }
                
                strongSelf.totalCount = result.totalCount
                let newViewModels = result.items.map { repository in
                    return RepositoryTableViewCellViewModel(repository: repository)
                }
                
                let currentViewModels = strongSelf.repositoryViewModels.value
                strongSelf.repositoryViewModels.accept(currentViewModels + newViewModels)
            case .error(let error):
                self?.error.accept(error)
            }
        }.disposed(by: disposeBag)
    }
    
    
}

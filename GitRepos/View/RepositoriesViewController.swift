//
//  RepositoriesViewController.swift
//  GitRepos
//
//  Created by Victor Magpali on 16/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RepositoriesViewController: UIViewController {
    
    private var viewModel: RepositoriesViewModelProtocol
    
    private var disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    private var refreshControl = UIRefreshControl()
    
    init(viewModel: RepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        setup()
        bindValues()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = tableView
    }
    
    override func viewDidLoad() {
        viewModel.refreshSearch()
    }
    
    private func setup() {
        title = "Swift"
        tableView.refreshControl = refreshControl
    }
    
    private func bindValues() {
        viewModel.repositoryViewModels
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryTableViewCell.reuseIdentifier,
                                         cellType: RepositoryTableViewCell.self)) { [weak self] row, element, cell in
                                            cell.setViews(with: element)
                                            self?.viewModel.currentRow.accept(row)
            }.disposed(by: disposeBag)
        
        viewModel.refreshing.bind(to: refreshControl.rx.isRefreshing).disposed(by: disposeBag)
        
        refreshControl.rx.controlEvent(.primaryActionTriggered).subscribe(onNext: { [weak self] in
            self?.viewModel.refreshSearch()
        }).disposed(by: disposeBag)
    }
    
    
}

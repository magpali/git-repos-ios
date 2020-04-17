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
    
    init(viewModel: RepositoriesViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
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
    
    private func bindValues() {
        viewModel.repositoryViewModels
            .bind(to: tableView.rx.items(cellIdentifier: RepositoryTableViewCell.reuseIdentifier,
                                         cellType: RepositoryTableViewCell.self)) { [weak self] row, element, cell in
                                            cell.setViews(with: element)
                                            self?.viewModel.currentRow.accept(row)
            }.disposed(by: disposeBag)
    }
    
    
}

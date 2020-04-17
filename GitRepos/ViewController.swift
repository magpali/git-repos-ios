//
//  ViewController.swift
//  GitRepos
//
//  Created by Victor Magpali on 15/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
 
        RepositorySearchResult.searchForRepositories(in: ["Swift"], sortBy: .stars, order: .ascending, page: 0).subscribe { event in
            switch event {
            case .success(let result):
                print(result)
            case .error(let error):
                print(error)
            }
        }.disposed(by: disposeBag)
    }


}


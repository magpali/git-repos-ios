//
//  RepositoryTableViewCellViewModel.swift
//  GitRepos
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import AlamofireImage
import RxCocoa
import RxSwift


class RepositoryTableViewCellViewModel: RepositoryCellViewModelProtocol {
    var repoNameObservable: BehaviorRelay<String>
    var repoDescriptionObservable: BehaviorRelay<String>
    var forksObservable: BehaviorRelay<String>
    var watchersObservable: BehaviorRelay<String>
    var avatarImageObservable: BehaviorRelay<UIImage>
    var ownerNameObservable: BehaviorRelay<String>
    
    private var avatarURL: String
    
    private var disposeBag = DisposeBag()
    
    init(repository: Repository) {
        repoNameObservable = BehaviorRelay<String>(value: repository.name)
        repoDescriptionObservable = BehaviorRelay<String>(value: repository.description)
        forksObservable = BehaviorRelay<String>(value: String(repository.forks))
        watchersObservable = BehaviorRelay<String>(value: String(repository.watchers))
        avatarImageObservable = BehaviorRelay<UIImage>(value: UIImage.init(named: .avatarIcon))
        ownerNameObservable = BehaviorRelay<String>(value: repository.owner.login)
        
        avatarURL = repository.owner.avatarUrl
    }
    
    func fetchImage() {
        guard let url = URL(string: avatarURL) else { return }
        
        RequestManager.requestImage(with: url).subscribe(onSuccess: { [weak self] image in
            self?.avatarImageObservable.accept(image)
        }).disposed(by: disposeBag)
    }
    

}

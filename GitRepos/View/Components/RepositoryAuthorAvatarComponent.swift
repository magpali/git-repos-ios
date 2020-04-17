//
//  RepositoryAuthorAvatarComponent.swift
//  GitRepos
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol RepositoryAuthorAvatarViewModelProtocol {
    var avatarImageObservable: Observable<UIImage> { get }
    var nameObservable: Observable<String> { get }
}

class RepositoryAuthorAvatarComponent: UIView {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var disposeBag = DisposeBag()
    
    private var viewModel: RepositoryAuthorAvatarViewModelProtocol
    
    init(viewModel: RepositoryAuthorAvatarViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        addSubviews()
        applyConstraints()
        bindValues()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([avatarImageView,
                     nameLabel])
    }
    
    private func applyConstraints() {
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
    }
    
    private func bindValues() {
        viewModel.avatarImageObservable.bind(to: avatarImageView.rx.image).disposed(by: disposeBag)
        viewModel.nameObservable.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
    }
    
}


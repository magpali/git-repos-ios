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
    var avatarImageObservable: BehaviorRelay<UIImage> { get }
    var ownerNameObservable: BehaviorRelay<String> { get }
    
    func fetchImage()
}

class RepositoryAuthorAvatarComponent: UIView {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        imageView.backgroundColor = UIColor.darkGray.withAlphaComponent(0.3)
        return imageView
    }()

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor.blue.withAlphaComponent(0.8)
        label.textAlignment = .center
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
        viewModel.fetchImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubviews([avatarImageView,
                     nameLabel])
    }
    
    private func applyConstraints() {
        avatarImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        avatarImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 10).isActive = true
        avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: centerYAnchor, constant: 10).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 10).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5).isActive = true
        nameLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
    }
    
    private func bindValues() {
        viewModel.avatarImageObservable.bind(to: avatarImageView.rx.image).disposed(by: disposeBag)
        viewModel.ownerNameObservable.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
    }
    
}


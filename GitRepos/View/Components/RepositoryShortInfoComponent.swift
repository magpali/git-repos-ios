//
//  RepositoryShortInfoComponent.swift
//  GitRepos
//
//  Created by Victor Magpali on 16/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol RepositoryShortInfoViewModelProtocol {
    var repoNameObservable: BehaviorRelay<String> { get }
    var repoDescriptionObservable: BehaviorRelay<String> { get }
    var forksObservable: BehaviorRelay<String> { get }
    var watchersObservable: BehaviorRelay<String> { get }
}

class RepositoryShortInfoComponent: UIView {
    
    private var repoNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor.blue.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var forksImageView: UIImageView = {
        let image = UIImage(named: .forkIcon).withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var forksLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var watchersImageView: UIImageView = {
        let image = UIImage(named: .starIcon).withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var watchersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .orange
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var disposeBag = DisposeBag()
    
    private var viewModel: RepositoryShortInfoViewModelProtocol
    
    init(viewModel: RepositoryShortInfoViewModelProtocol) {
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
        addSubviews([repoNameLabel,
                     descriptionLabel,
                     forksImageView,
                     forksLabel,
                     watchersImageView,
                     watchersLabel])
    }
    
    private func applyConstraints() {
        repoNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        repoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        repoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        
        forksImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        forksImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        forksImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        forksImageView.centerYAnchor.constraint(equalTo: forksLabel.centerYAnchor).isActive = true
        
        forksLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        forksLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: 4).isActive = true
        forksLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -10).isActive = true
        
        watchersImageView.leadingAnchor.constraint(equalTo: forksLabel.trailingAnchor, constant: 10).isActive = true
        watchersImageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        watchersImageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        watchersImageView.centerYAnchor.constraint(equalTo: forksLabel.centerYAnchor).isActive = true
        
        watchersLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        watchersLabel.leadingAnchor.constraint(equalTo: watchersImageView.trailingAnchor, constant: 4).isActive = true
        watchersLabel.centerYAnchor.constraint(equalTo: forksLabel.centerYAnchor).isActive = true
    }
    
    private func bindValues() {
        viewModel.repoNameObservable.bind(to: repoNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.repoDescriptionObservable.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.forksObservable.bind(to: forksLabel.rx.text).disposed(by: disposeBag)
        viewModel.watchersObservable.bind(to: watchersLabel.rx.text).disposed(by: disposeBag)
    }
    
}

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
    var nameObservable: Observable<String> { get }
    var descriptionObservable: Observable<String> { get }
    var forksObservable: Observable<String> { get }
    var starsObservable: Observable<String> { get }
}

class RepositoryShortInfoComponent: UIView {
    
    private var repoNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var forksImageView: UIImageView = {
        let image = UIImage(named: .forkIcon).withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
    
    private var starsImageView: UIImageView = {
        let image = UIImage(named: .starIcon).withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .orange
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var starsLabel: UILabel = {
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
                     starsImageView,
                     starsLabel])
    }
    
    private func applyConstraints() {
        repoNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        repoNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        repoNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: repoNameLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
        
        forksImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        forksImageView.topAnchor.constraint(equalTo: forksLabel.topAnchor).isActive = true
        forksImageView.bottomAnchor.constraint(equalTo: forksLabel.topAnchor).isActive = true
        
        forksLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        forksLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: 4).isActive = true
        
        starsImageView.leadingAnchor.constraint(equalTo: starsLabel.trailingAnchor, constant: 10).isActive = true
        starsImageView.topAnchor.constraint(equalTo: starsLabel.topAnchor).isActive = true
        starsImageView.bottomAnchor.constraint(equalTo: starsLabel.topAnchor).isActive = true
        
        starsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        starsLabel.leadingAnchor.constraint(equalTo: forksImageView.trailingAnchor, constant: 4).isActive = true
        starsLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: 10).isActive = true
    }
    
    private func bindValues() {
        viewModel.nameObservable.bind(to: repoNameLabel.rx.text).disposed(by: disposeBag)
        viewModel.descriptionObservable.bind(to: descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.forksObservable.bind(to: forksLabel.rx.text).disposed(by: disposeBag)
        viewModel.starsObservable.bind(to: starsLabel.rx.text).disposed(by: disposeBag)
    }
    
}

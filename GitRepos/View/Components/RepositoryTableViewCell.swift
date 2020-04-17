//
//  RepositoryTableViewCell.swift
//  GitRepos
//
//  Created by Victor Magpali on 16/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit

typealias RepositoryCellViewModelProtocol = RepositoryShortInfoViewModelProtocol &
                                            RepositoryAuthorAvatarViewModelProtocol

class RepositoryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "RepositoryTableViewCell"
    
    private var repositoryInfoComponent: RepositoryShortInfoComponent?
    private var repositoryAuthorAvatarComponent: RepositoryAuthorAvatarComponent?
    
    func setViews(with viewModel: RepositoryCellViewModelProtocol) {
        repositoryInfoComponent = RepositoryShortInfoComponent(viewModel: viewModel)
        repositoryAuthorAvatarComponent = RepositoryAuthorAvatarComponent(viewModel: viewModel)
        
        setup()
        addSubviews()
        applyConstraints()
    }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .white
    }

    private func addSubviews() {
        guard let infoComponent = repositoryInfoComponent,
            let authorAvatarComponent = repositoryAuthorAvatarComponent else { return }
            
        addSubviews([infoComponent,
                     authorAvatarComponent])
    }
    
    private func applyConstraints() {
        guard let infoComponent = repositoryInfoComponent,
            let authorAvatarComponent = repositoryAuthorAvatarComponent else { return }
        
        infoComponent.translatesAutoresizingMaskIntoConstraints = false
        infoComponent.topAnchor.constraint(equalTo: topAnchor).isActive = true
        infoComponent.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        infoComponent.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        authorAvatarComponent.translatesAutoresizingMaskIntoConstraints = false
        authorAvatarComponent.leadingAnchor.constraint(equalTo: infoComponent.trailingAnchor).isActive = true
        authorAvatarComponent.topAnchor.constraint(equalTo: topAnchor).isActive = true
        authorAvatarComponent.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        authorAvatarComponent.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        authorAvatarComponent.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    override func prepareForReuse() {
        guard let infoComponent = repositoryInfoComponent,
            let authorAvatarComponent = repositoryAuthorAvatarComponent else { return }
        
        infoComponent.removeFromSuperview()
        authorAvatarComponent.removeFromSuperview()
    }
    
}

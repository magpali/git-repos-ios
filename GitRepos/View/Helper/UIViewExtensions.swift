//
//  UIViewExtensions.swift
//  GitRepos
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit.UIView

extension UIView {
    
    func addSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
    
}

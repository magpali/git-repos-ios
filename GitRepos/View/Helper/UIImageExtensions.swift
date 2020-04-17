//
//  UIImageExtensions.swift
//  GitRepos
//
//  Created by Victor Magpali on 17/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit.UIImage

extension UIImage {
    //If this force unwrap crashed you have a typo in the Asset enum :S
    convenience init(named asset: Asset) {
        self.init(named: asset.rawValue)!
    }
}


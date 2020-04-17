//
//  AppDelegate.swift
//  GitRepos
//
//  Created by Victor Magpali on 15/04/20.
//  Copyright © 2020 Victor Magpali. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let initialViewController = RepositoriesViewController(viewModel: RepositoriesViewModel())
        let navigationController = UINavigationController(rootViewController: initialViewController)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}


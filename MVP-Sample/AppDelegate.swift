//
//  AppDelegate.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/10/29.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        LocalShoesRepository.removeAll()
        setupFirstView()
        return true
    }

    // MARK: private
    
    func setupFirstView () {
        window = UIWindow()
        window?.rootViewController = ShoesListViewBuilder().buildWithNavigationController()
        window?.makeKeyAndVisible()
    }
}


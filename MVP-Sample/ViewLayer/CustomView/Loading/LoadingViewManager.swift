//
//  LoadingViewManager.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/19.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

/// Make a loading indicator
class LoadingViewManager {
    
    /// Show loading indicator for R88
    class func show(autoClose time: TimeInterval = 0) {
 
        guard shared.window == nil else { return }
        shared.makeWindow()
    }
    
    /// Dismiss loading indicator for R88
    class func dismiss() {

        guard shared.window != nil else { return }
        shared.window = nil
    }
    
    // MARK: - Private

    private static let shared: LoadingViewManager = LoadingViewManager()
    private var window: UIWindow?
    
    private init() { }

    private func makeWindow() {
        
        let loadingView = LoadingImageView(frame: CGRect.zero)
        loadingView.startAnimating()
        
        let vc = BaseViewController()
        vc.view.backgroundColor = UIColor(white: 0, alpha: 0.8)
        vc.view.addSubview(loadingView)
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        loadingView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = vc
        window?.windowLevel = UIWindow.Level(1300)
        window?.makeKeyAndVisible()
    }
}

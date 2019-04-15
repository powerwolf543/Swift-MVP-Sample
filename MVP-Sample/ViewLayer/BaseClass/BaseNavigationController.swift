//
//  BaseNavigationController.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2018/11/9.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updatedTheme()
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    private func updatedTheme() {
        
        navigationBar.barStyle = .blackOpaque
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = ThemeColor.pureBlack.color
        navigationBar.tintColor = ThemeColor.pureWhite.color
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

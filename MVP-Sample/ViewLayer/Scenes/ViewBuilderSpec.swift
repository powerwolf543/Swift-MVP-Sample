//
//  ViewBuilderSpec.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/12.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

protocol ViewBuilderSpec {
    
    associatedtype ViewType: UIViewController
    
    func build() -> ViewType
    func buildWithNavigationController() -> BaseNavigationController
}

extension ViewBuilderSpec {
    
    func buildWithNavigationController() -> BaseNavigationController {
        return BaseNavigationController(rootViewController: build())
    }
}

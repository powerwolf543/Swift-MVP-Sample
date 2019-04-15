//
//  UIStoryboard+Extensions.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/12.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    /// Instantiate a UIViewController using its class name
    ///
    /// - Parameter name: UIViewController type
    /// - Returns: The view controller corresponding to specified class name
    func instantiateViewController<T: UIViewController>(withClass name: T.Type) -> T {
        guard let viewController = instantiateViewController(withIdentifier: String(describing: name)) as? T else {
            fatalError("storyboard identifier not found.")
        }
        return viewController
    }
    
}

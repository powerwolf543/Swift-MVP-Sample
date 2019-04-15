//
//  NotificationUtility.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/10.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol Notifiable {
    
    var name: Notification.Name { get }
    
    func observed<T: AnyObject>(by observer: T, withSelector selector: Selector, object: Any?)
    func post(object: Any?, userInfo: [AnyHashable: Any]?)
    func remove<T: AnyObject>(observer: T)
}

extension Notifiable {
    
    func observed<T: AnyObject>(by observer: T, withSelector selector: Selector, object: Any? = nil) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    
    func post(object: Any? = nil, userInfo: [AnyHashable: Any]? = nil) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    func remove<T: AnyObject>(observer: T) {
        NotificationCenter.default.removeObserver(observer, name: name, object: nil)
    }
    
    var name: Notification.Name {
        let name = "kNotificationKeyOf\(String(describing: Self.self))_\(String(describing: self))"
        return Notification.Name(name)
    }
}

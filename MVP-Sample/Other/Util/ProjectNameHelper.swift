//
//  ProjectNameHelper.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/19.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import Foundation

struct ProjectNameHelper: NameProvidable {
    
    var name: String {
        guard
            let info = Bundle.main.infoDictionary,
            let bundleName = info["CFBundleName"] as? String else {
            fatalError()
        }
        return bundleName
    }
}

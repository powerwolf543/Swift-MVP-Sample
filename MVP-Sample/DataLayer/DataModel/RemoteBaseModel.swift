//
//  RemoteBaseModel.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct RemoteBaseModel<T: Codable>: Codable {
    let code: Int
    let msg: String
    let body: T
}

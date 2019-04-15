//
//  String+extensions.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/11.
//  Copyright © 2018年 NixonShih. All rights reserved.
//

import Foundation

extension String {
    
    func toBase64() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
}

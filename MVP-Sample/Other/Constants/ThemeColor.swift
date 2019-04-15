//
//  ThemeColor.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2018/11/9.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

enum ThemeColor: String {
    
    case pureBlack = "000000"
    case pureWhite = "ffffff"
    case darkBlack = "252525"
    case darkRed = "b41b1b"
    
    var color: UIColor {
        let hex = Int(self.rawValue, radix: 16)
        return UIColor(rgb: hex ?? 0x000000)
    }
}

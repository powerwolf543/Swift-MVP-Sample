//
//  ShoesModel.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/10.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import Foundation

struct ShoesModel: Codable {

    let date: String
    let description: String?
    var imageName: String
    let nickname: String?
    let price: Int
    let title: String
}

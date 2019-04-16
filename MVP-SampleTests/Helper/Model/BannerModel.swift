//
//  BannerModel.swift
//  MVP-SampleTests
//
//  Created by NixonShih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

@testable import MVP_Sample

extension BannerModel: Equatable {
    
    public static func == (lhs: BannerModel, rhs: BannerModel) -> Bool {
        return lhs.imageName + (lhs.url?.absoluteString ?? "") == rhs.imageName + (rhs.url?.absoluteString ?? "")
    }
}

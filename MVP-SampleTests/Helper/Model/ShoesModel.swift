//
//  ShoesModel.swift
//  MVP-SampleTests
//
//  Created by NixonShih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

@testable import MVP_Sample

extension ShoesModel {
    
    static var newShoes: ShoesModel {
        return ShoesModel(date: "2018-06-28", description: "123", imageName: "456", nickname: "Just Do It Collection", price: 130, title: "Nike Air Force 1 ’07 PRM")
    }
}

extension ShoesModel: Equatable {
    
    public static func == (lhs: ShoesModel, rhs: ShoesModel) -> Bool {
        return lhs.date + lhs.title + String(lhs.price) + lhs.imageName ==
            rhs.date + rhs.title + String(rhs.price) + rhs.imageName
    }
}


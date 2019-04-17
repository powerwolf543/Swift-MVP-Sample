//
//  ShoesRepositorySpec.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/11.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol ShoesRepositorySpec {
    
    typealias FetchShoesCompletionHandler = (Result<[ShoesModel], Error>) -> ()
    func fetchShoes(_ completionHandler: @escaping FetchShoesCompletionHandler)
}

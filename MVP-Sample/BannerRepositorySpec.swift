//
//  BannerRepositorySpec.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol BannerRepositorySpec {
    
    typealias FetchBannerCompletionHandler = (Result<[BannerModel], Error>) -> ()
    func fetchBanners(_ completionHandler: @escaping FetchBannerCompletionHandler)
}

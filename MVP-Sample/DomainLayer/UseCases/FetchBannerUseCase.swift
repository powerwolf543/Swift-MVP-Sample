//
//  FetchBannerUseCase.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol FetchBannerUseCaseSpec {
    
    typealias FetchBannersUseCaseCompletionHandler = (_ books: Result<[BannerModel], Error>) -> ()
    func fetchBanners(_ completionHandler: @escaping FetchBannersUseCaseCompletionHandler)
}

struct FetchBannerUseCase: FetchBannerUseCaseSpec {
    
    init(repository: BannerRepositorySpec) {
        self.repository = repository
    }
    
    func fetchBanners(_ completionHandler: @escaping FetchBannersUseCaseCompletionHandler) {
        repository.fetchBanners(completionHandler)
    }
    
    // MARK: private
    
    private let repository: BannerRepositorySpec
}

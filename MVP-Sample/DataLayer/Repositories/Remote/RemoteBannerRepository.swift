//
//  RemoteBannerRepository.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct RemoteBannerRepository<AnyNetworkFetchable>: BannerRepositorySpec where AnyNetworkFetchable: NetworkFetchable, AnyNetworkFetchable.DataModel == [RemoteBannerModel] {
    
    init(fetcher: AnyNetworkFetchable) {
        self.fetcher = fetcher
    }
    
    func fetchBanners(_ completionHandler: @escaping FetchBannerCompletionHandler) {
        fetcher.fire { (result) in
            switch result {
            case .success(let dataModel):
                completionHandler(Result.success(dataModel))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
    
    // MARK: private
    
    private let fetcher: AnyNetworkFetchable
}

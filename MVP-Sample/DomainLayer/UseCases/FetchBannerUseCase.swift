//
//  FetchBannerUseCase.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct FetchBannerUseCase: FetchDataUseCaseSpec {
    
    typealias DataModel = [BannerModel]
    
    init(repository: BannerRepositorySpec) {
        self.repository = repository
    }
    
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        DispatchQueue.global().async {
            self.repository.fetchBanners { (result) in
                switch result {
                case .success(let dataModel):
                    DispatchQueue.main.async(execute: {
                        completionHandler(Result.success(dataModel.map(self.mapBanner).shuffled()))
                    })
                case .failure(let error):
                    DispatchQueue.main.async {
                        completionHandler(Result.failure(error))
                    }
                }
            }
        }
    }
    
    // MARK: private
    
    private let repository: BannerRepositorySpec
    
    private func mapBanner(_ remoteBanner: RemoteBannerModel) -> BannerModel {
        return BannerModel(imageName: remoteBanner.imageName, url: URL(string: remoteBanner.url))
    }
}

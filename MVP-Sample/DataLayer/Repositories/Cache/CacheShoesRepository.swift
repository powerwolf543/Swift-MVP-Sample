//
//  CacheShoesRepository.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/11.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct CacheShoesRepository: ShoesRepositorySpec {
    
    init(remoteRepository: ShoesRepositorySpec, localRepository: LocalShoesRepositorySpec) {
        self.remoteRepository = remoteRepository
        self.localRepository = localRepository
    }
    
    func fetchShoes(_ completionHandler: @escaping FetchShoesCompletionHandler) {
        remoteRepository.fetchShoes { (result) in
            switch result {
            case .success(let dataModel):
                self.localRepository.save(shoes: dataModel, completionHandler: nil)
                completionHandler(result)
            case .failure(_):
                self.localRepository.fetchShoes(completionHandler)
            }
        }
    }
    
    // MARK: private
    
    private var remoteRepository: ShoesRepositorySpec
    private var localRepository: LocalShoesRepositorySpec
}

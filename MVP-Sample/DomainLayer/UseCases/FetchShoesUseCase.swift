//
//  FetchShoesUseCase.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/11.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct FetchShoesUseCase: FetchDataUseCaseSpec {
    
    typealias DataModel = [ShoesModel]
    
    init(repository: ShoesRepositorySpec) {
        self.repository = repository
    }
    
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler) {
        repository.fetchShoes(completionHandler)
    }
    
    // MARK: private
    
    private let repository: ShoesRepositorySpec
}

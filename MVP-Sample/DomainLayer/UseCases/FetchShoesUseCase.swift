//
//  FetchShoesUseCase.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/11.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol FetchShoesUseCaseSpec {
    
    typealias FetchShoesUseCaseCompletionHandler = (_ books: Result<[ShoesModel], Error>) -> ()
    func fetchShoes(_ completionHandler: @escaping FetchShoesUseCaseCompletionHandler)
}

struct FetchShoesUseCase: FetchShoesUseCaseSpec {
    
    init(repository: ShoesRepositorySpec) {
        self.repository = repository
    }
    
    func fetchShoes(_ completionHandler: @escaping FetchShoesUseCaseCompletionHandler) {
        repository.fetchShoes(completionHandler)
    }
    
    // MARK: private
    
    private let repository: ShoesRepositorySpec
}

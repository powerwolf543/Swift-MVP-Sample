//
//  FetchShoesRepository.swift
//  MVP-SampleTests
//
//  Created by NixonShih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

@testable import MVP_Sample

enum MockFetchShoesRepositoryError: Error {
    case fail
}

class MockFetchShoesRepository: ShoesRepositorySpec {

    var expectedResult: Result<[ShoesModel], Error>!
    
    func fetchShoes(_ completionHandler: @escaping FetchShoesCompletionHandler) {
        completionHandler(expectedResult)
    }
}

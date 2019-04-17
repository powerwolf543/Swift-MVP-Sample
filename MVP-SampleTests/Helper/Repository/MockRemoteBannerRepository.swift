//
//  MockRemoteBannerRepository.swift
//  MVP-SampleTests
//
//  Created by NixonShih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

@testable import MVP_Sample

enum MockRemoteBannerRepositoryError: Error {
    case fail
}

class MockRemoteBannerRepository: BannerRepositorySpec {
    
    func fetchBanners(_ completionHandler: @escaping FetchBannerCompletionHandler) {
        completionHandler(expectedResult)
    }
    
    var expectedResult: Result<[RemoteBannerModel], Error>!
}

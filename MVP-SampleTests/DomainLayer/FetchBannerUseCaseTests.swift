//
//  FetchBannerUseCaseTests.swift
//  MVP-SampleTests
//
//  Created by NixonShih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import XCTest
@testable import MVP_Sample

class FetchBannerUseCaseTests: XCTestCase {
    
    var repository = MockRemoteBannerRepository()
    lazy var fetchBannersUseCase = FetchBannerUseCase(repository: repository)
    
    func testSuccessCallBack() {
        
        let banners = [RemoteBannerModel(imageName: "123", url: ""),
                     RemoteBannerModel(imageName: "456", url: "789"),
                     RemoteBannerModel(imageName: "098", url: "http://www.a.com")]
        let expectedResult: Result<[RemoteBannerModel], Error> = .success(banners)
        repository.expectedResult = expectedResult
        let expectedBanners = [BannerModel(imageName: "123", url: nil),
                               BannerModel(imageName: "456", url: URL(string: "789")),
                               BannerModel(imageName: "098", url: URL(string: "http://www.a.com"))]
        let completionHandlerExpectation = expectation(description: "Fetch shoes expectation")
        
        fetchBannersUseCase.fetchDataModel { (result) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model, expectedBanners)
                completionHandlerExpectation.fulfill()
            case .failure: break
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    
    func testFailCallBack() {

        let theError = MockRemoteBannerRepositoryError.fail
        let expectedResult: Result<[RemoteBannerModel], Error> = .failure(theError)
        repository.expectedResult = expectedResult
        let completionHandlerExpectation = expectation(description: "Fetch shoes expectation")

        fetchBannersUseCase.fetchDataModel { (result) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case MockRemoteBannerRepositoryError.fail:
                    completionHandlerExpectation.fulfill()
                default: break
                }
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

//
//  FetchShoesUseCaseTests.swift
//  MVP-SampleTests
//
//  Created by NixonShih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import XCTest
@testable import MVP_Sample

class FetchShoesUseCaseTests: XCTestCase {

    var repository = MockFetchShoesRepository()
    lazy var fetchShoesUseCase = FetchShoesUseCase(repository: repository)
    
    func testSuccessCallBack() {
        
        let shoes = [ShoesModel.newShoes]
        let expectedResult: Result<[ShoesModel], Error> = .success(shoes)
        repository.expectedResult = expectedResult
        let completionHandlerExpectation = expectation(description: "Fetch shoes expectation")
        
        fetchShoesUseCase.fetchDataModel { (result) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model, shoes)
                completionHandlerExpectation.fulfill()
            case .failure: break
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }


    func testFailCallBack() {
        
        let theError = MockFetchShoesRepositoryError.fail
        let expectedResult: Result<[ShoesModel], Error> = .failure(theError)
        repository.expectedResult = expectedResult
        let completionHandlerExpectation = expectation(description: "Fetch shoes expectation")
        
        fetchShoesUseCase.fetchDataModel { (result) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case MockFetchShoesRepositoryError.fail:
                    completionHandlerExpectation.fulfill()
                default: break
                }
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}

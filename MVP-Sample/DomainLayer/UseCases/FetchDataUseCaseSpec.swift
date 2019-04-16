//
//  FetchDataUseCaseSpec.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/16.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol FetchDataUseCaseSpec {
    
    associatedtype DataModel
    
    typealias FetchDataModelUseCaseCompletionHandler = (_ books: Result<DataModel, Error>) -> ()
    func fetchDataModel(_ completionHandler: @escaping FetchDataModelUseCaseCompletionHandler)
}

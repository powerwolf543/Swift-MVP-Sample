//
//  NetworkFetchable.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/19.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case url
    case encode
    case connection
    case decode
    case emptyContent
    case serviceError
}

protocol NetworkFetchable {
    
    associatedtype DataModel: Codable
    func fire(_ completionHandler: @escaping (Result<DataModel, NetworkError>) -> ())
}

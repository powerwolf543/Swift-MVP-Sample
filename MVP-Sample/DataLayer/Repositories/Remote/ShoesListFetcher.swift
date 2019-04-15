//
//  ShoesListFetcher.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/19.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import Foundation

struct ShoesListFetcher: NetworkFetchable {
    
    typealias DataModel = [ShoesModel]
    
    func fire(_ completionHandler: @escaping (Result<[ShoesModel], NetworkError>) -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let data = self.getDummyData()
            do {
                let response = try JSONDecoder().decode(RemoteBaseModel<DataModel>.self, from: data)
                guard response.code == 0 else {
                    completionHandler(Result.failure(NetworkError.serviceError))
                    return
                }
                completionHandler(Result.success(response.body))
            } catch {
                completionHandler(Result.failure(NetworkError.decode))
            }
        }
    }
    
    // MARK: private
    
    private func getDummyData() -> Data {
        
        guard
            let url = Bundle.main.url(forResource: "shoes_list_remote_source", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                fatalError("Couldn't get dummy data.")
        }
        return data
    }
}

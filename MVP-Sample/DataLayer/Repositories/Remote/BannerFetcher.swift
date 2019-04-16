//
//  BannerFetcher.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct BannerFetcher: NetworkFetchable {
    
    typealias DataModel = [RemoteBannerModel]
    
    func fire(_ completionHandler: @escaping (Result<[RemoteBannerModel], NetworkError>) -> ()) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
            let url = Bundle.main.url(forResource: "banner_remote_source", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                fatalError("Couldn't get dummy data.")
        }
        return data
    }
}

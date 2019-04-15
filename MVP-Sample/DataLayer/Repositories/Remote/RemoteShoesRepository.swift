//
//  RemoteShoesRepository.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/11.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

struct RemoteShoesRepository<AnyNetworkFetchable>: ShoesRepositorySpec where AnyNetworkFetchable: NetworkFetchable, AnyNetworkFetchable.DataModel == [ShoesModel] {
    
    init(fetcher: AnyNetworkFetchable) {
        self.fetcher = fetcher
    }
    
    func fetchShoes(_ completionHandler: @escaping FetchShoesCompletionHandler) {
        fetcher.fire { (result) in
            switch result {
            case .success(let dataModel):
                completionHandler(Result.success(dataModel.sorted(by: self.sortedShose)))
            case .failure(let error):
                completionHandler(Result.failure(error))
            }
        }
    }
    
    // MARK: private
    
    private let fetcher: AnyNetworkFetchable
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    private func sortedShose(shoes1: ShoesModel, shoes2: ShoesModel) -> Bool {
        return dateFormatter.date(from: shoes1.date)! > dateFormatter.date(from: shoes2.date)!
    }
}

//
//  LocalShoesRepository.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/11.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol LocalShoesRepositorySpec: ShoesRepositorySpec {
    
    typealias SaveShoesCompletionHandler = (Result<Void, Error>) -> ()
    func save(shoes: [ShoesModel], completionHandler: SaveShoesCompletionHandler?)
}

enum LocalShoesRepositoryError: Error {
    case noLocalCache
}

/// Cache dataModel to userDefaults
struct LocalShoesRepository: LocalShoesRepositorySpec {
    
    func save(shoes: [ShoesModel], completionHandler: SaveShoesCompletionHandler?) {
        do {
            let data = try JSONEncoder().encode(shoes)
            UserDefaults.standard.set(data, forKey: LocalShoesRepository.localShoesListPersistKey)
            completionHandler?(Result.success(()))
        } catch {
            completionHandler?(Result.failure(error))
        }
    }
    
    func fetchShoes(_ completionHandler: @escaping FetchShoesCompletionHandler) {

        guard let data = UserDefaults.standard.data(forKey: LocalShoesRepository.localShoesListPersistKey) else {
            completionHandler(Result.failure(LocalShoesRepositoryError.noLocalCache))
            return
        }
        
        do {
            let dataModel = try JSONDecoder().decode([ShoesModel].self, from: data)
            completionHandler(Result.success(dataModel))
        } catch {
            completionHandler(Result.failure(error))
        }
    }
    
    static func removeAll() {
        UserDefaults.standard.removeObject(forKey: localShoesListPersistKey)
    }
    
    // MARK: private
    
    private static let localShoesListPersistKey = "kLocalShoesListPersistKey"
    
    private func getDummyData() -> Data {
        
        guard
            let url = Bundle.main.url(forResource: "shoes_list_firt_time", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
                fatalError("Couldn't get dummy data.")
        }
        return data
    }
}

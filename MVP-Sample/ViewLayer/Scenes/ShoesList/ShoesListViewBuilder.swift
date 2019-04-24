//
//  ShoesListViewBuilder.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/12.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

/// The builder of ShoesListViewController
struct ShoesListViewBuilder: ViewBuilderSpec {

    /// builds ViewController and injects dependency of components.
    func build() -> ShoesListViewController {
        
        let remoteRepository = RemoteShoesRepository(fetcher: ShoesListFetcher())
        let cacheRepository = CacheShoesRepository(remoteRepository: remoteRepository, localRepository: LocalShoesRepository())
        let fetchLocalShoesUseCaes = FetchShoesUseCase(repository: LocalShoesRepository())
        let fetchShoesUseCaes = FetchShoesUseCase(repository: cacheRepository)
        let vc = UIStoryboard.main.instantiateViewController(withClass: ShoesListViewController.self)
        vc.bannerViewController = ShoesListBannerBuilder().build()
        vc.presenter = ShoesListPresenter(
            fetchShoesUseCase: fetchShoesUseCaes,
            fetchLocalShoesUseCaseSpec: fetchLocalShoesUseCaes,
            router: ShoesListRouter(performer: vc),
            bannerPresenter: vc.bannerViewController.presenter,
            nameProvider: ProjectNameHelper()
        )
        vc.presenter.eventReceiver = vc
        return vc
    }
}

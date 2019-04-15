//
//  ShoesListBannerBuilder.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

/// The builder of ShoesListBannerViewController
struct ShoesListBannerBuilder: ViewBuilderSpec {
    
    /// builds ViewController and injects dependency of components.
    func build() -> ShoesListBannerViewController {
        
        let fetcher = BannerFetcher()
        let repository = RemoteBannerRepository(fetcher: fetcher)
        let useCase = FetchBannerUseCase(repository: repository)
        let vc = UIStoryboard.main.instantiateViewController(withClass: ShoesListBannerViewController.self)
        let presenter = ShoesListBannerPresenter(fetchBannerUseCase: useCase, router: ShoesListBannerRouter(performer: vc))
        vc.presenter = presenter
        presenter.eventReceiver = vc
        return vc
    }
}

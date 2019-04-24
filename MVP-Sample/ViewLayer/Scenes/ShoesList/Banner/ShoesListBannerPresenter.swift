//
//  ShoesListBannerPresenter.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol ShoesListBannerViewEventReceiverable: class {
    func receivedEventOfStartLoading()
    func receivedEventOfReload()
    func receivedEventOfLoadFail()
}

protocol ShoesListBannerPresenterSpec {
    
    var eventReceiver: ShoesListBannerViewEventReceiverable? { get set }
    var countOfItem: Int { get }
    
    func setup()
    func getImageName(by index: Int) -> String
    func didSelect(at index: Int)
}

class ShoesListBannerPresenter<AnyFetchBannerUseCase>: ShoesListBannerPresenterSpec where AnyFetchBannerUseCase: FetchDataUseCaseSpec, AnyFetchBannerUseCase.DataModel == [BannerModel] {
    
    init(fetchBannerUseCase: AnyFetchBannerUseCase, router: ShoesListBannerRouterSpec) {
        self.fetchBannerUseCase = fetchBannerUseCase
        self.router = router
    }
    
    func setup() {
        eventReceiver?.receivedEventOfStartLoading()
    }
    
    weak var eventReceiver: ShoesListBannerViewEventReceiverable?
    var countOfItem: Int { return banners.count }
    
    func getImageName(by index: Int) -> String {
        return banners[index].imageName
    }
    
    func didSelect(at index: Int) {
        guard let url = banners[index].url else { return }
        router.pushWebView(with: url)
    }
    
    // MARK: private
    
    private var banners: [BannerModel] = []
    private let fetchBannerUseCase: AnyFetchBannerUseCase
    private let router: ShoesListBannerRouterSpec
    
    private func fetchBanners() {
        if banners.isEmpty { self.eventReceiver?.receivedEventOfStartLoading() }
        
        fetchBannerUseCase.fetchDataModel { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let dataModel):
                self.banners = dataModel
                self.eventReceiver?.receivedEventOfReload()
            case .failure:
                self.eventReceiver?.receivedEventOfLoadFail()
            }
        }
    }
}

extension ShoesListBannerPresenter: ShoesListSubpresenterOfBannerSpec {
    
    func receivedEventOfReloadFromSuperPresenter() {
        fetchBanners()
    }
}

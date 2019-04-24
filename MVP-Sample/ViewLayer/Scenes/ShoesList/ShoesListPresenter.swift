//
//  ShoesListPresenter.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/6.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

protocol ShoesListPresenterSpec {
    
    var eventReceiver: ShoesListViewEventReceiverable? { get set }
    var rowOfList: Int { get }
    
    func setup()
    func viewWillAppear()
    func didDropDownList()
    func getCellModel(by row: Int) -> ShoesListCellModel
    func didSelect(at row: Int) 
}

protocol ShoesListViewEventReceiverable: class {
    func receivedEventOfSetupViews(with setupModel: ShoesListViewSetupModel)
    func receivedEventOfRefreshList()
    func receivedEventOfShowLoadingUI()
    func receivedEventOfShowAlert(title: String, content: String)
    func receivedEventOfShowFailView()
}

protocol ShoesListSubpresenterOfBannerSpec {
    func receivedEventOfReloadFromSuperPresenter()
}

struct ShoesListViewSetupModel {
    let title: String
}

class ShoesListPresenter<AnyFetchShoesUseCase>: ShoesListPresenterSpec where AnyFetchShoesUseCase: FetchDataUseCaseSpec, AnyFetchShoesUseCase.DataModel == [ShoesModel] {
    
    init(fetchShoesUseCase: AnyFetchShoesUseCase,
         fetchLocalShoesUseCaseSpec: AnyFetchShoesUseCase,
         router: ShoesListRouterSpec,
         bannerPresenter: ShoesListSubpresenterOfBannerSpec,
         nameProvider: NameProvidable) {
        
        self.fetchShoesUseCase = fetchShoesUseCase
        self.fetchLocalShoesUseCaseSpec = fetchLocalShoesUseCaseSpec
        self.router = router
        self.bannerPresenter = bannerPresenter
        self.nameProvider = nameProvider
    }
    
    weak var eventReceiver: ShoesListViewEventReceiverable?
    var rowOfList: Int { return shoes.count }
    
    func setup() {
        let setupModel = ShoesListViewSetupModel(title: nameProvider.name)
        eventReceiver?.receivedEventOfSetupViews(with: setupModel)
        fetchLoaclShoes()
    }
    
    func viewWillAppear() {
        fetchShoes()
        bannerPresenter.receivedEventOfReloadFromSuperPresenter()
    }
    
    func didDropDownList() {
        fetchShoes()
    }

    func getCellModel(by row: Int) -> ShoesListCellModel {
        let theShoes = shoes[row]
        return ShoesListCellModel(
            title: theShoes.title, price: "$" + String(theShoes.price), date: theShoes.date, imageName: theShoes.imageName
        )
    }
    
    func didSelect(at row: Int) {
        let theShoes = shoes[row]
        router.pushDetailView(with: theShoes)
    }
    
    // MARK: Private
    
    private let fetchShoesUseCase: AnyFetchShoesUseCase
    private let fetchLocalShoesUseCaseSpec: AnyFetchShoesUseCase
    private let router: ShoesListRouterSpec
    private let bannerPresenter: ShoesListSubpresenterOfBannerSpec
    private let nameProvider: NameProvidable
    private var shoes: [ShoesModel] = []
    
    private func fetchShoes() {
        
        if shoes.isEmpty { eventReceiver?.receivedEventOfShowLoadingUI() }
        
        fetchShoesUseCase.fetchDataModel { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let shoes):
                self.shoes = shoes
                self.eventReceiver?.receivedEventOfRefreshList()
            case .failure:
                if self.shoes.isEmpty {
                    self.eventReceiver?.receivedEventOfShowFailView()
                }else{
                    self.eventReceiver?.receivedEventOfShowAlert(title: "Fail", content: "An error occurred, please try again later.")
                }
            }
        }
    }
    
    private func fetchLoaclShoes() {
        
        fetchLocalShoesUseCaseSpec.fetchDataModel { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let shoes):
                self.shoes = shoes
                self.eventReceiver?.receivedEventOfRefreshList()
            case .failure: break
            }
        }
    }
}

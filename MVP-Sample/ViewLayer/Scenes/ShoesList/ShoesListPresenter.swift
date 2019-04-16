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
    func fetchData()
    func getCellModel(by row: Int) -> ShoesListCellModel
    func didSelect(at row: Int) 
}

protocol ShoesListViewEventReceiverable: class {
    func receivedEventOfSetupViews(with initialModel: ShoesListViewInitialModel)
    func receivedEventOfRefreshList()
    func receivedEventOfShowLoadingUI()
    func receivedEventOfShowAlert(title: String, content: String)
    func receivedEventOfShowFailView()
}

struct ShoesListViewInitialModel {
    let title: String
}

class ShoesListPresenter<AnyFetchShoesUseCase>: ShoesListPresenterSpec where AnyFetchShoesUseCase: FetchDataUseCaseSpec, AnyFetchShoesUseCase.DataModel == [ShoesModel] {
    
    init(fetchShoesUseCase: AnyFetchShoesUseCase,
         fetchLocalShoesUseCaseSpec: AnyFetchShoesUseCase,
         router: ShoesListRouterSpec,
         nameProvider: NameProvidable) {
        
        self.fetchShoesUseCase = fetchShoesUseCase
        self.fetchLocalShoesUseCaseSpec = fetchLocalShoesUseCaseSpec
        self.router = router
        self.nameProvider = nameProvider
    }
    
    weak var eventReceiver: ShoesListViewEventReceiverable?
    var rowOfList: Int { return shoes.count }
    
    func setup() {
        let initialModel = ShoesListViewInitialModel(title: nameProvider.name)
        eventReceiver?.receivedEventOfSetupViews(with: initialModel)
        fetchLoaclShoes()
    }
    
    func fetchData() {
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

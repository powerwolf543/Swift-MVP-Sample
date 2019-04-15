//
//  ShoesDetailPresenter.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol ShoesDetailViewEventReceiverable: class {
    func receivedEventOfSetupViews(with initialModel: ShoesDetailViewInitialModel)
}

protocol ShoesDetailPresenterSpec {
    
    var eventReceiver: ShoesDetailViewEventReceiverable? { get set }
    var rows: Int { get }
    
    func setup()
    func getRowType(by row: Int) -> ShoesDetailRow
    func getInfoCellModel() -> ShoesDetailInfoCellModel
    func getDescriptionCellModel() -> ShoesDetailDescriptionCellModel
}

struct ShoesDetailViewInitialModel {
    let title: String
    let productImageName: String
}

class ShoesDetailPresenter: ShoesDetailPresenterSpec {
    
    var rows: Int { return 2 }
    weak var eventReceiver: ShoesDetailViewEventReceiverable?
    
    init(shoes: ShoesModel) {
        self.shoes = shoes
    }
    
    func setup() {
        let initialModel = ShoesDetailViewInitialModel(title: "Detail", productImageName: shoes.imageName)
        eventReceiver?.receivedEventOfSetupViews(with: initialModel)
    }
    
    func getRowType(by row: Int) -> ShoesDetailRow {
        guard let type = ShoesDetailRow(rawValue: row)
            else { fatalError("Unknown row.") }
        return type
    }
    
    func getInfoCellModel() -> ShoesDetailInfoCellModel {
        return ShoesDetailInfoCellModel(
            title: shoes.title, price: "$" + String(shoes.price), date: shoes.date, nickName: shoes.nickname ?? ""
        )
    }
    
    func getDescriptionCellModel() -> ShoesDetailDescriptionCellModel {
        return ShoesDetailDescriptionCellModel(description: shoes.description ?? "")
    }
    
    // MARK: Private
    
    private let shoes: ShoesModel
}

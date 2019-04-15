//
//  ShoesDetailViewBuilder.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

/// The builder of ShoesDetailViewController
struct ShoesDetailViewBuilder: ViewBuilderSpec {
    
    init(shoes: ShoesModel) {
        self.shoes = shoes
    }
    
    func build() -> ShoesDetailViewController {
        let vc = UIStoryboard.main.instantiateViewController(withClass: ShoesDetailViewController.self)
        vc.presenter = ShoesDetailPresenter(shoes: shoes)
        vc.presenter.eventReceiver = vc
        return vc
    }
    
    // MARK: private
    
    private let shoes: ShoesModel
}

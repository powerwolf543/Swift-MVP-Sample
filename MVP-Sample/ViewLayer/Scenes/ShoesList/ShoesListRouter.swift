//
//  ShoesListRouter.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

protocol ShoesListRouterSpec {
    func pushDetailView(with shoes: ShoesModel)
}

struct ShoesListRouter: ShoesListRouterSpec {
    
    init(performer: ShoesListViewController) {
        self.performer = performer
    }
    
    func pushDetailView(with shoes: ShoesModel) {
        let vc = ShoesDetailViewBuilder(shoes: shoes).build()
        performer.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: private
    
    private weak var performer: ShoesListViewController!
}

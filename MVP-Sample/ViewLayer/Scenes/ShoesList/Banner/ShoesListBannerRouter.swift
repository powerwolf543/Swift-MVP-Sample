//
//  ShoesListBannerRouter.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/15.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit
import SafariServices

protocol ShoesListBannerRouterSpec {
    func pushWebView(with url: URL)
}

struct ShoesListBannerRouter: ShoesListBannerRouterSpec {
    
    init(performer: ShoesListBannerViewController) {
        self.performer = performer
    }
    
    func pushWebView(with url: URL) {
        let vc = SFSafariViewController(url: url)
        performer.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: private
    
    private weak var performer: ShoesListBannerViewController!
}

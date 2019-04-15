//
//  ShoesListBannerCollectionViewCell.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

class ShoesListBannerCollectionViewCell: UICollectionViewCell, SetReuseViewModelable {
    
    @IBOutlet weak var bannerImageView: UIImageView!

    func setReuseViewMode(_ viewModel: String) {
        bannerImageView.image = UIImage(named: viewModel)
        bannerImageView.contentMode = .scaleAspectFit
    }

}

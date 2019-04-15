//
//  ShoesListTableViewCell.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/10.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

struct ShoesListCellModel {
    let title: String
    let price: String
    let date: String
    let imageName: String
}

class ShoesListTableViewCell: UITableViewCell, SetReuseViewModelable {    
    
    @IBOutlet weak var shoesImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setReuseViewMode(_ viewModel: ShoesListCellModel) {
        shoesImageView.image = UIImage(named: viewModel.imageName)
        titleLabel.text = viewModel.title
        dateLabel.text = viewModel.date
        priceLabel.text = viewModel.price
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: private
    
    private func setup() {
        selectionStyle = .none
    }
}

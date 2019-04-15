//
//  ShoesDetailInfoTableViewCell.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

struct ShoesDetailInfoCellModel {
    let title: String
    let price: String
    let date: String
    let nickName: String
}

class ShoesDetailInfoTableViewCell: UITableViewCell, SetReuseViewModelable {    
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func setReuseViewMode(_ viewModel: ShoesDetailInfoCellModel) {
        nickNameLabel.text = viewModel.nickName
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

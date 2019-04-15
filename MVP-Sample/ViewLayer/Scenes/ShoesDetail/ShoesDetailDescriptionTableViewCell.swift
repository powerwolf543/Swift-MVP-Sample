//
//  ShoesDetailDescriptionTableViewCell.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

struct ShoesDetailDescriptionCellModel {
    let description: String
}

class ShoesDetailDescriptionTableViewCell: UITableViewCell, SetReuseViewModelable {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func setReuseViewMode(_ viewModel: ShoesDetailDescriptionCellModel) {
        descriptionLabel.text = viewModel.description
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

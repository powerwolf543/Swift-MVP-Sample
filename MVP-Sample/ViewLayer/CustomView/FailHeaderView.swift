//
//  FailHeaderView.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/21.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

class FailHeaderView: UIView {
    
    // MARK: Initialize
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customSetting()
    }

    // MARK: Private methods
    
    private func customSetting() {
        
        backgroundColor = ThemeColor.darkRed.color
        
        let label = UILabel()
        label.text = "Failure: please try again later"
        label.textColor = ThemeColor.pureWhite.color
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}

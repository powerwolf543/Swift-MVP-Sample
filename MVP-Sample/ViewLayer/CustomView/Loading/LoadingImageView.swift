//
//  LoadingImageView.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/11/19.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

class LoadingImageView: UIImageView {
    
    // MARK: Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customSetting()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customSetting()
    }
    
    private override init(image: UIImage?, highlightedImage: UIImage? = nil) {
        super.init(image: image, highlightedImage: highlightedImage)
        customSetting()
    }

    // MARK: Private methods
    
    private func customSetting() {
        
        var images = [UIImage]()
        
        for i in 0...29 {
            guard let image = UIImage(named: "frame-\(i)") else { continue }
            images.append(image)
        }
        
        contentMode = .center
        animationImages = images
        animationDuration = 0.8
    }
}

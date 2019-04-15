//
//  ScrollViewCalculator.swift
//  MVP-Sample
//
//  Created by Nixon.Shih on 2019/4/15.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

class ScrollViewCalculator {
    
    enum Direction {
        case up
        case down
    }
    
    init(scrollView: UIScrollView, originOffset: CGFloat = 0) {
        self.scrollView = scrollView
        previousScrollOffset = originOffset
    }
    
    var scrollDifference: CGFloat {
        return scrollView.contentOffset.y - previousScrollOffset
    }
    
    var moveDirection: Direction {
        return scrollDifference > 0 ? .up : .down
    }
    
    var previousScrollOffset: CGFloat
    
    // MARK: private
    
    private let scrollView: UIScrollView
}

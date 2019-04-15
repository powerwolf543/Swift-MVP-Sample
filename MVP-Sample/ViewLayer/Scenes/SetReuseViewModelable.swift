//
//  SetReuseViewModelable.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import Foundation

protocol SetReuseViewModelable {
    
    associatedtype ViewModel
    func setReuseViewMode(_ viewModel: ViewModel)
}

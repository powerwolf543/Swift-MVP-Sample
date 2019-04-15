//
//  ShoesDetailViewController.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/13.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

class ShoesDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productImageHeightContraint: NSLayoutConstraint!
    
    var presenter: ShoesDetailPresenterSpec!
    
    // MARK: override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.setup()        
    }
    
    // MARK: private
    
    private let headerAndPaddingHeight: CGFloat = 260
    private lazy var scrollHelper: ScrollViewCalculator = {
       return ScrollViewCalculator(scrollView: tableView, originOffset: -headerAndPaddingHeight)
    }()
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        var contentInset = tableView.contentInset
        contentInset.top = headerAndPaddingHeight
        tableView.contentInset = contentInset
    }
}

enum ShoesDetailRow: Int {
    case info
    case description
}

// MARK: ShoesDetailViewEventReceiverable

extension ShoesDetailViewController: ShoesDetailViewEventReceiverable {
    
    func receivedEventOfSetupViews(with initialModel: ShoesDetailViewInitialModel) {
        productImageView.image = UIImage(named: initialModel.productImageName)
        title = initialModel.title
    }
}

// MARK: UITableViewDataSource

extension ShoesDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch presenter.getRowType(by: indexPath.row) {
        case .info:
            let cell = tableView.dequeueReusableCell(withClass: ShoesDetailInfoTableViewCell.self, for: indexPath)
            let viewModel = presenter.getInfoCellModel()
            cell.setReuseViewMode(viewModel)
            return cell
        case .description:
            let cell = tableView.dequeueReusableCell(withClass: ShoesDetailDescriptionTableViewCell.self, for: indexPath)
            let viewModel = presenter.getDescriptionCellModel()
            cell.setReuseViewMode(viewModel)
            return cell
        }
    }
}

// MARK: UITableViewDelegate

extension ShoesDetailViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var newHeight = productImageHeightContraint.constant
        
        switch scrollHelper.moveDirection {
        case .up:
             newHeight = max(0, newHeight - abs(scrollHelper.scrollDifference))
        case .down:
            newHeight = newHeight + abs(scrollHelper.scrollDifference)
        }

        if newHeight != productImageHeightContraint.constant {
            productImageHeightContraint.constant = newHeight
        }
        scrollHelper.previousScrollOffset = scrollView.contentOffset.y
    }
}

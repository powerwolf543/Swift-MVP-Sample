//
//  ShoesListBannerViewController.swift
//  MVP-Sample
//
//  Created by NixonShih on 2019/4/14.
//  Copyright © 2019 NixonShih. All rights reserved.
//

import UIKit

class ShoesListBannerViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var presenter: (ShoesListBannerPresenterSpec & ShoesListSubpresenterOfBannerSpec)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.setup()
    }
    
    // MARK: private
    
    private enum State {
        case initial
        case loading
        case showBanner
    }
    
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial: break
            case .loading: enableLoadingUI(true)
            case .showBanner: showBannerUI()
            }
        }
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .clear
    }
    
    private func enableLoadingUI(_ enable: Bool) {
        guard enable else {
            collectionView.backgroundView = nil
            return
        }
        
        let loadingView = UIActivityIndicatorView(style: .white)
        loadingView.startAnimating()
        collectionView.backgroundView = loadingView
    }
    
    private func showBannerUI() {
        enableLoadingUI(false)
        collectionView.reloadData()
    }
}

// MARK: ShoesListBannerViewEventReceiverable

extension ShoesListBannerViewController: ShoesListBannerViewEventReceiverable {
    
    func receivedEventOfStartLoading() {
        state = .loading
    }
    
    func receivedEventOfReload() {
        state = .showBanner
    }
    
    func receivedEventOfLoadFail() {
        state = .loading
    }
}

// MARK: UICollectionViewDataSource

extension ShoesListBannerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.countOfItem
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: ShoesListBannerCollectionViewCell.self, for: indexPath)
        cell.setReuseViewMode(presenter.getImageName(by: indexPath.row))
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension ShoesListBannerViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath.row)
    }
}

// MARK: UICollectionViewDelegateFlowLayout

extension ShoesListBannerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

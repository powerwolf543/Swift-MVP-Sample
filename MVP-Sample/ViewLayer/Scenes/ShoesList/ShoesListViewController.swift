//
//  ShoesListViewController.swift
//  MVP-Sample
//
//  Created by NixonShih on 2018/10/29.
//  Copyright © 2018 NixonShih. All rights reserved.
//

import UIKit

class ShoesListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: ShoesListPresenterSpec!
    weak var bannerViewController: ShoesListBannerViewController! {
        didSet { addChild(bannerViewController) }
    }
    
    // MARK: override
    
    override func loadView() {
        super.loadView()
        layoutBanner()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        presenter.setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.eventReceiver = self
        presenter.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        presenter.eventReceiver = nil
    }
    
    // MARK: private
    
    private enum State {
        case initial
        case loading
        case showList
        case showFailUI
    }
    
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial: break
            case .loading: enableLoadingUI(true)
            case .showList: updateList()
            case .showFailUI: setupFailView()
            }
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlDidPull), for: .valueChanged)
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    private lazy var scrollHelper: ScrollViewCalculator = {
        return ScrollViewCalculator(scrollView: tableView, originOffset: -bannerHeight)
    }()
    private var bannerViewTopConstraint: NSLayoutConstraint?
    private let bannerHeight: CGFloat = UIScreen.main.bounds.width / 3
    
    @objc private func refreshControlDidPull() {
        presenter.fetchData()
    }
    
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
        
        var contentInset = tableView.contentInset
        contentInset.top = bannerHeight
        tableView.contentInset = contentInset
    }
    
    private func layoutBanner() {
        
        view.addSubview(bannerViewController.view)
        bannerViewController.didMove(toParent: self)
        bannerViewController.view.translatesAutoresizingMaskIntoConstraints = false

        bannerViewTopConstraint = bannerViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        NSLayoutConstraint.activate([
            bannerViewTopConstraint!,
            bannerViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            bannerViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            bannerViewController.view.heightAnchor.constraint(equalToConstant: bannerHeight)
            ])
    }
    
    private func enableLoadingUI(_ enable: Bool) {
        guard enable else {
            tableView.backgroundView = nil
            return
        }
        
        let loadingView = UIActivityIndicatorView(style: .white)
        loadingView.startAnimating()
        tableView.backgroundView = loadingView
    }
    
    private func updateList() {
        enableLoadingUI(false)
        tableView.reloadData()
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
    }
    
    private func setupFailView() {
        tableView.backgroundView = FailHeaderView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
    }
}

// MARK: ShoesListViewEventReceiverable

extension ShoesListViewController: ShoesListViewEventReceiverable {
    
    func receivedEventOfSetupViews(with initialModel: ShoesListViewInitialModel) {
        title = initialModel.title
    }
    
    func receivedEventOfRefreshList() {
        state = .showList
    }
    
    func receivedEventOfShowLoadingUI() {
        state = .loading
    }
    
    func receivedEventOfShowAlert(title: String, content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
   
    func receivedEventOfShowFailView() {
        state = .showFailUI
    }

}

// MARK: UITableViewDataSource

extension ShoesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.rowOfList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ShoesListTableViewCell.self, for: indexPath)
        let viewModel = presenter.getCellModel(by: indexPath.row)
        cell.setReuseViewMode(viewModel)
        return cell
    }
}

// MARK: UITableViewDelegate

extension ShoesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let bannerViewTopConstraint = bannerViewTopConstraint else { return }
        var newTop = bannerViewTopConstraint.constant
        
        switch (scrollHelper.moveDirection, scrollView.contentOffset.y) {
        case (.up, (-bannerHeight)...):
                newTop = newTop - abs(scrollHelper.scrollDifference)
                newTop = newTop > -bannerHeight ? newTop : -bannerHeight
        case (.down, ...0):
                newTop = min(0, newTop + abs(scrollHelper.scrollDifference))
        default: break
        }
        
        if newTop != bannerViewTopConstraint.constant {
            bannerViewTopConstraint.constant = newTop
        }
        scrollHelper.previousScrollOffset = scrollView.contentOffset.y
    }
}

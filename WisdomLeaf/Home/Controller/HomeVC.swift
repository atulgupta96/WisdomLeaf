//
//  HomeVC.swift
//  WisdomLeaf
//
//  Created by Atul Gupta on 02/05/23.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.registerCell(type: HomeTableRowCell.self)
            tableView.contentInset = .zero
        }
    }
    
    //MARK: Private Variables
    private var viewModel = HomeViewModel()
    private var refreshControl: UIRefreshControl?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBarTitle()
        fetchPhotos()
    }
    
    //MARK: Private Methods
    private func setNavBarTitle() {
        title = "Photo list"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupRefreshControl() {
        if refreshControl == nil {
            refreshControl = UIRefreshControl()
            refreshControl?.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
            tableView.refreshControl = refreshControl
            
        } else {
            refreshControl?.endRefreshing()
        }
    }
    
    @objc func onPullToRefresh() {
        viewModel.pageState = .idle
        viewModel.page = 0
        fetchPhotos()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(withType: HomeTableRowCell.self, for: indexPath) as! HomeTableRowCell
        cell.selectionStyle = .none
        cell.setupView(viewModel.photos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let isChecked = !(viewModel.photos[indexPath.row].isChecked ?? false)
        viewModel.photos[indexPath.row].isChecked = isChecked
        tableView.reloadData()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height - 50 {
            fetchPhotos()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.pageState == .idle ? 50 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let container = UIView()
        container.backgroundColor = .clear
        
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        container.addSubview(activityIndicator)
        
        activityIndicator.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        return container
    }
}

//MARK: API Calls
extension HomeVC {
    private func fetchPhotos() {
        
        if !(refreshControl?.isRefreshing ?? false) && viewModel.page == 0 {
            showLoader()
        }
        
        viewModel(.getPhotos)
        
        viewModel.photosCallback = {
            self.removeLoader()
            self.tableView.reloadData()
            self.setupRefreshControl()
        }
        
        viewModel.errorCallback = { error in
            self.removeLoader()
            self.alert(error)
        }
    }
}

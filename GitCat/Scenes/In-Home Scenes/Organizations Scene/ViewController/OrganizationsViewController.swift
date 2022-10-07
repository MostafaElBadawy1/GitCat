//
//  OrganizationsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 23/08/2022.
//
import UIKit
class OrganizationsViewController: UIViewController {
    //MARK: - Props
    var passedNameFromUserDetailsVC: String?
    var orgsArray = [OrganizationModel]()
    var organizationsViewModel = OrganizationsViewModel()
    let loadingIndicator = UIActivityIndicatorView()
    var searchController = UISearchController()
    //MARK: - IBOutlets
    @IBOutlet weak var orgsTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    //MARK: - Main Functions
    func initView() {
        tableViewConfig()
        networkReachability(loadingIndicator: loadingIndicator)
        refreshPage()
    }
    func initViewModel() {
        if let userName = passedNameFromUserDetailsVC {
            searchControllerConfig()
            fetchOrgs(userName: userName)
            searchController.searchBar.text = userName
        }
    }
    //MARK: - View Functions
    func tableViewConfig() {
        orgsTableView.delegate = self
        orgsTableView.dataSource = self
        orgsTableView.register(UINib(nibName: K.organizationsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.organizationsTableViewCellID)
        orgsTableView.frame = view.bounds
        orgsTableView.rowHeight = 80
        navigationItem.title = "Organizations"
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.delegate = self
       // searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search Organizations"
    }
    func orgsLabelConfig(){
        let label = UILabel()
        label.text = "No Organizations Available."
        label.font = UIFont.systemFont(ofSize: 18)
        label.frame =  CGRect(x: 100, y: 400, width:300, height: 50)
        self.view.addSubview(label)
    }
    func refreshPage(){
        self.orgsTableView.refreshControl = UIRefreshControl()
        self.orgsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        if let userName = passedNameFromUserDetailsVC {
            fetchOrgs(userName: userName)
        }
        self.orgsTableView.reloadData()
    }
    //MARK: - Data Functions
    func fetchOrgs(userName: String) {
        organizationsViewModel.fetchOrgs(userName: userName)
        organizationsViewModel.bindingData = { orgs, error in
                if let orgsData = orgs {
                    self.orgsArray = orgsData
                    DispatchQueue.main.async {
                        self.orgsTableView.reloadData()
                        self.loadingIndicator.stopAnimating()
                        if self.orgsArray.isEmpty {
                            self.orgsLabelConfig()
                        }
                    }
                }
                if let error = error {
                    self.presentAlert(title: "Error While Fetching Organizations", message: "")
                    print(error)
                }
            }
    }
}


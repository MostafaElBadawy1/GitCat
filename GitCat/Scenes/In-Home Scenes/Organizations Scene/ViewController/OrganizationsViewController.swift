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
        networkReachability()
        refreshPage()
    }
    func initViewModel() {
        if let userName = passedNameFromUserDetailsVC {
            fetchOrgs(userName: userName)
        }
    }
    //MARK: - View Functions
    func tableViewConfig() {
        orgsTableView.delegate = self
        orgsTableView.dataSource = self
        orgsTableView.register(UINib(nibName: K.OrganizationsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.OrganizationsTableViewCellID)
        orgsTableView.frame = view.bounds
        orgsTableView.rowHeight = 80
        navigationItem.title = "Organizations"
    }
    func orgsLabelConfig(){
        let label = UILabel()
        label.text = "No Organizations Available."
        label.font = UIFont.systemFont(ofSize: 18)
        label.frame =  CGRect(x: 100, y: 400, width:300, height: 50)
        self.view.addSubview(label)
    }
    func networkReachability(){
        loadingIndicator.style = .medium
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        if NetworkMonitor.shared.isConnected {
            loadingIndicator.stopAnimating()
        } else {
            presentAlert(title: "You Are Disconnected" , message: "Please Check Your Connection !")
            loadingIndicator.startAnimating()
        }
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
    func presentAlert(title: String , message: String) {
        let alert : UIAlertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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


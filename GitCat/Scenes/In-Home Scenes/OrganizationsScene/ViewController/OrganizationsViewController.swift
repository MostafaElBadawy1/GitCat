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
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.frame =  CGRect(x: 100, y: 400, width:300, height: 50)
        
        //if orgsArray.isEmpty {
        self.view.addSubview(label)
        //}
    }
    func networkReachability(){
        loadingIndicator.style = .medium
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        if NetworkMonitor.shared.isConnected {
            loadingIndicator.stopAnimating()
        } else {
            let alert : UIAlertController = UIAlertController(title:"You Are Disconnected" , message: "Please Check Your Connection !", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loadingIndicator.startAnimating()
        }
    }
    func refreshPage(){
        self.orgsTableView.refreshControl = UIRefreshControl()
        self.orgsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchOrgs(userName: passedNameFromUserDetailsVC!)
        self.orgsTableView.reloadData()
    }
    //MARK: - Data Functions
    func fetchOrgs(userName: String) {
        Task.init {
            if let orgs = await organizationsViewModel.fetchUserOrg(userName: userName) {
                self.orgsArray = orgs
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.orgsTableView.reloadData()
                }
                if orgsArray.isEmpty {
                    orgsTableView.isHidden = true
                    orgsLabelConfig()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Organizations" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
extension OrganizationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orgsTableView.dequeueReusableCell(withIdentifier: K.OrganizationsTableViewCellID) as! OrganizationsTableViewCell
        cell.orgNameLabel.text = orgsArray[indexPath.row].login
        cell.orgDescriptionLabel.text = orgsArray[indexPath.row].description
        cell.orgImageView.kf.setImage(with: URL(string: orgsArray[indexPath.row].avatar_url!), placeholder: UIImage(named: "Organization"))
        return cell
    }
}

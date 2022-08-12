//
//  UsersListViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import UIKit
import Kingfisher
import Alamofire
class UsersListViewController: UIViewController {
    //MARK: - Props
    var usersViewModel = UsersListViewModel()
    var usersArray: [Users] = []
    var filteredArray: [Users] = []
    let searchController = UISearchController(searchResultsController: resultsTableController())
    let loadingIndicator = UIActivityIndicatorView()
    //MARK: - IBOutlets
    @IBOutlet weak var usersListTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
//        navigationController?.navigationBar.prefersLargeTitles = true
//        self.usersListTableView.refreshControl = UIRefreshControl()
//        self.usersListTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkReachability()
//        self.usersListTableView.refreshControl = UIRefreshControl()
//         self.usersListTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        searchControllerConfig()
        pagination()
    }
    func InitViewModel(){
        fetchUsers()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.register(UINib(nibName: K.UsersListTableViewCell, bundle: .main), forCellReuseIdentifier: K.UserListCellID)
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    func networkReachability(){
        loadingIndicator.style = .medium
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        if NetworkMonitor.shared.isConnected {
           print("connected")
            loadingIndicator.stopAnimating()
        } else {
            print("Disconnected")
            let alert : UIAlertController = UIAlertController(title:"You Are Disconnected!" , message: "Please Check Your Connection", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loadingIndicator.startAnimating()
        }
    }
    func pagination(){
        self.usersListTableView.refreshControl = UIRefreshControl()
        self.usersListTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchUsers()
    }
    //MARK: - Data Function
    func fetchUsers() {
        usersViewModel.fetchAllUsers()
        usersViewModel.bindingData = { users, error in
            if let users = users {
                self.usersArray = users
                self.filteredArray = self.usersArray
                DispatchQueue.main.async {
                    self.usersListTableView.reloadData()
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: - SearchBar
extension UsersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredArray = usersArray
            self.usersListTableView.reloadData()
        } else {
            filteredArray = usersArray.filter({ user in
                return user.login!.contains(searchText.lowercased())
            })
            self.usersListTableView.reloadData()
        }
    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        usersSearchBar.endEditing(true)
//    }
//    func searchBarSearchButtonClicked(searchBar: UISearchBar)
//    {
////        searchActive = false;
//        self.usersSearchBar.endEditing(true)
//    }
}
extension UsersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
        return
    }
    print(text)
    
}
}

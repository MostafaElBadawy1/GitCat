//
//  UsersListViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//
import UIKit
import Kingfisher
class UsersListViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var usersViewModel = UsersListViewModel()
    var usersArray = [Items]()
    var moreUsersArray = [Items]()
    var searchController = UISearchController()
    let loadingIndicator = UIActivityIndicatorView()
    //var usersSearchResultViewController = UsersSearchResultViewController()
    //var cellDelegate : CellLink?
    //var index: IndexPath?
    //MARK: - IBOutlets
    @IBOutlet weak var usersListTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
        // usersSearchResultViewController =
        //(self.storyboard?.instantiateViewController(withIdentifier: "UsersSearchResultViewController") as? UsersSearchResultViewController)!
        //usersSearchResultViewController.usersResultTableView.delegate = self
        //searchController = UISearchController(searchResultsController: resultsTableController)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkReachability()
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        searchControllerConfig()
        refreshPage()
    }
    func InitViewModel(){
        fetchUsers(searchKeyword: "mo", page: 1)
    }
    //MARK: - View Functions
    func tableViewConfig() {
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.prefetchDataSource = self
        usersListTableView.register(UINib(nibName: K.UsersListTableViewCell, bundle: .main), forCellReuseIdentifier: K.UserListCellID)
        usersListTableView.frame = view.frame
        //        self.usersListTableView.tableFooterView = createSpinnerFooter()
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        //searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    func createSpinnerFooter()-> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.center = footerView.center
        spinner.startAnimating()
        return footerView
    }
    func networkReachability(){
        loadingIndicator.style = .medium
        loadingIndicator.center = view.center
        view.addSubview(loadingIndicator)
        if NetworkMonitor.shared.isConnected {
            loadingIndicator.stopAnimating()
        } else {
            let alert : UIAlertController = UIAlertController(title:"You Are Disconnected" , message: "Please Check Your Connection!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loadingIndicator.startAnimating()
        }
    }
    func refreshPage(){
        self.usersListTableView.refreshControl = UIRefreshControl()
        self.usersListTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchUsers(searchKeyword: "mo", page: 1)
        self.usersListTableView.reloadData()
    }
    //MARK: - Data Function
    func fetchUsers(searchKeyword: String, page: Int) {
        Task.init {
            if let users = await usersViewModel.fetchAllUsers(searchKeyword: searchKeyword, page: page) {
                self.usersArray = users
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.usersListTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Users" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func fetchMoreUsers(searchKeyword: String, page: Int) {
        Task.init {
            if let users = await usersViewModel.fetchAllUsers(searchKeyword: searchKeyword, page: page) {
//                try await Task.sleep(nanoseconds: 1_000_000_000)
                self.moreUsersArray = users
                DispatchQueue.main.async {
                    self.usersArray.append(contentsOf: self.moreUsersArray)
                    self.usersListTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Users" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    //    func fetchUsers(id: Int) {
    //        usersViewModel.fetchAllUsers(id: id)
    //        usersViewModel.bindingData = { users, error in
    //            if let users = users {
    //                self.usersArray = users
    //                //self.filteredArray = self.usersArray
    //                DispatchQueue.main.async {
    ////                    self.usersArray.append(contentsOf: self.usersArray)
    //                    self.usersListTableView.reloadData()
    //                }
    //            }
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    //    func fetchMoreUsers(id: Int) {
    //        usersViewModel.fetchAllUsers(id: id)
    //        usersViewModel.bindingData = { users, error in
    //            if let users = users {
    //                self.moreUsersArray = users
    //                //self.filteredArray = self.usersArray
    //                DispatchQueue.main.async {
    //                    self.usersListTableView.tableFooterView = nil
    //                    self.usersArray.append(contentsOf: self.moreUsersArray)
    //                    self.usersListTableView.reloadData()
    //                }
    //            }
    //            if let error = error {
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
}

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
    var pageNumber = 1
    var page = 0
    var preFetchIndex = 15
    var usersViewModel = UsersListViewModel()
    var usersArray = [UserModel]()
    var moreUsersArray = [UserModel]()
    var searchController = UISearchController()
    let loadingIndicator = UIActivityIndicatorView()
    let searchHistoryVC = SearchHistoryViewController()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usersModel = [User]()
    let noUserslabel = UILabel()
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
        //setup()
    }
    func InitViewModel(){
        fetchUsers(for: "mo")
    }
    //MARK: - View Functions
    func setup(){
        addChild(searchHistoryVC)
        self.view.addSubview(searchHistoryVC.view)
        searchHistoryVC.didMove(toParent: self)
        searchHistoryVC.view.frame = self.view.bounds
        //searchHistoryVC.view.isHidden = true
    }
    func tableViewConfig() {
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.prefetchDataSource = self
        usersListTableView.register(UINib(nibName: K.usersListTableViewCell, bundle: .main), forCellReuseIdentifier: K.UserListCellID)
        usersListTableView.frame = view.bounds
        loadingIndicator.backgroundColor = .black
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
            presentAlert (title: "You Are Disconnected", message: "Please Check Your Connection!")
            loadingIndicator.startAnimating()
        }
    }
    func refreshPage(){
        self.usersListTableView.refreshControl = UIRefreshControl()
        self.usersListTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchUsers(for: "mo")
        self.usersListTableView.reloadData()
        noUserslabel.isHidden = true
    }
    func searchHistoryVCConfig() {
        searchHistoryVC.view.isHidden = true
        usersListTableView.isHidden  = false
        //loadingIndicator.isHidden = false
    }
    func presentAlert (title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title:title , message: title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func LabelConfig(){
        noUserslabel.text = "There aren't any users."
        noUserslabel.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        noUserslabel.frame =  CGRect(x: 110, y: 400, width:300, height: 50)
        self.view.addSubview(noUserslabel)
    }
    //MARK: - Data Functions
    func fetchUsers(for searchKeyword: String) {
        self.loadingIndicator.startAnimating()
        usersViewModel.fetchSearchedUsers(searchWord: searchKeyword, PageNum: 1)
        usersViewModel.bindingData = { [self] users, error in
            if let usersList = users {
                self.usersArray = usersList
                DispatchQueue.main.async {
                    self.usersListTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    if self.usersArray.count == 0 {
                        self.LabelConfig()
                    }
                }
            }
            if let error = error {
                presentAlert (title: "Error While Fetching Users", message: "")
                print(error)
            }
        }
    }
    func fetchMoreUsers(for searchKeyword: String, pageNum: Int) {
        usersViewModel.fetchSearchedUsers(searchWord: searchKeyword, PageNum: pageNum)
        usersViewModel.bindingData = { [self] users, error in
            if let usersList = users {
                self.moreUsersArray = usersList
                DispatchQueue.main.async {
                    self.usersArray.append(contentsOf: self.moreUsersArray)
                    self.loadingIndicator.stopAnimating()
                    self.usersListTableView.reloadData()
                    self.usersListTableView.tableFooterView = nil
                }
            }
            if let error = error {
                presentAlert (title: "Error While Fetching More Users", message: "")
                print(error)
            }
        }
    }
}
    //    func fetchMoreUsers(searchKeyword: String, page: Int) {
    //        Task.init {
    //            if let users = await usersViewModel.fetchAllUsers(searchKeyword: searchKeyword, page: page) {
    ////                try await Task.sleep(nanoseconds: 1_000_000_000)
    //                self.moreUsersArray = users
    //                DispatchQueue.main.async {
    //                    self.usersArray.append(contentsOf: self.moreUsersArray)
    //                    self.usersListTableView.reloadData()
    //                }
    //            } else {
    //                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Users" , message: "", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //            }
    //        }
    //    }
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


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
    var pageNumber = 2
    var preFetchIndex = 15
    var usersViewModel = UsersListViewModel()
    var usersArray = [UserModel]()
    var moreUsersArray = [UserModel]()
    var searchController = UISearchController()
    let loadingIndicator = UIActivityIndicatorView()
    var searchHistoryVC = SearchHistoryViewController()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usersModel = [User]()
    var visitedUserArray = [VisitedUser]()
    var searchedWordsArray = [SearchedWord]()
    let noUserslabel = UILabel()
    let firstlabel = UILabel()
    let secondlabel = UILabel()
    var passedTextFromSearch: String?
    //MARK: - IBOutlets
    @IBOutlet weak var usersListTableView: UITableView!
    @IBOutlet weak var searchHistoryTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        networkReachability()
        searchHistoryTableView.reloadData()
    }
    //MARK: - Main Functions
    func initView(){
        usersTableViewConfig()
        searchHistoryTableViewConfig()
        searchControllerConfig()
        refreshPage()
    }
    func InitViewModel(){
        fetchUsers(for: "mo")
        fetchSearchedWords()
        fetchVisitedUsers()
        if let passedText = passedTextFromSearch {
            fetchUsers(for: passedText)
            searchController.searchBar.text = passedText
        }
    }
    //MARK: - View Functions
    func usersTableViewConfig() {
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.prefetchDataSource = self
        usersListTableView.register(UINib(nibName: K.usersListTableViewCell, bundle: .main), forCellReuseIdentifier: K.UserListCellID)
        usersListTableView.frame = view.bounds
        loadingIndicator.backgroundColor = .black
    }
    func searchHistoryTableViewConfig() {
        searchHistoryTableView.delegate = self
        searchHistoryTableView.dataSource = self
        searchHistoryTableView.register(UINib(nibName: K.CollectionViewTableViewCellID, bundle: .main), forCellReuseIdentifier:  K.CollectionViewTableViewCellID)
        searchHistoryTableView.register(UINib(nibName: K.RecentSearchTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RecentSearchTableViewCellID)
        searchHistoryTableView.frame = view.bounds
        searchHistoryTableView.isHidden = true
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        //searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search For Users."
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
        let alert : UIAlertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func LabelConfig() {
        noUserslabel.text = "There aren't any users."
        noUserslabel.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        noUserslabel.frame =  CGRect(x: 110, y: 400, width:300, height: 50)
        self.view.addSubview(noUserslabel)
    }
    func emptySearchVClabelsConfig(){
        firstlabel.frame = CGRect(x: 0, y: 0, width: 200, height: 21)
        firstlabel.center = CGPoint(x: 200, y: 420)
        firstlabel.textAlignment = .center
        firstlabel.text = "Find Your stuff."
        firstlabel.font = .boldSystemFont(ofSize: 19)
        self.view.addSubview(firstlabel)
        secondlabel.frame =  CGRect(x: 0, y: 0, width: 400, height: 60)
        secondlabel.center = CGPoint(x: 205, y: 475)
        secondlabel.textAlignment = .center
        secondlabel.text = "Search all of GitHub for People, Repositories, Organizations, Issues, and Pull Requests"
        secondlabel.numberOfLines = 0
        secondlabel.textColor = .gray
        self.view.addSubview(secondlabel)
    }
    //MARK: - Data Functions
    func fetchUsers(for searchKeyword: String) {
        self.loadingIndicator.startAnimating()
        usersViewModel.fetchSearchedUsers(searchWord: searchKeyword, PageNum: 1)
        usersViewModel.bindingData = { users, error in
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
                self.presentAlert (title: "Error While Fetching Users", message: "")
                print(error)
            }
        }
    }
    func fetchMoreUsers(for searchKeyword: String, pageNum: Int) {
        usersViewModel.fetchSearchedUsers(searchWord: searchKeyword, PageNum: pageNum)
        usersViewModel.bindingData = { users, error in
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
                self.presentAlert (title: "Error While Fetching More Users", message: "")
                print(error)
            }
        }
    }
    func fetchSearchedWords() {
        CoreDataManger.shared.fetch(entityName: SearchedWord.self) { (words, error) in
            if let words = words {
                self.searchedWordsArray = words
                DispatchQueue.main.async {
                    self.searchHistoryTableView.reloadData()
                }
            } else {
                print(error!)
                self.presentAlert (title: "Error While Fetching Search History Words", message: "")
            }
            
        }
    }
    func fetchVisitedUsers() {
        CoreDataManger.shared.fetch(entityName: VisitedUser.self) { (users, error) in
            if let users = users {
                self.visitedUserArray = users
                DispatchQueue.main.async {
                    self.searchHistoryTableView.reloadData()
                }
            }  else {
                print(error!)
                self.presentAlert (title: "Error While Fetching Search History Users", message: "")
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


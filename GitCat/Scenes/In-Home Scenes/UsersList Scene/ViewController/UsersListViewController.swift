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
    var usersViewModel = UsersListViewModel()
    var usersArray = [UserModel]()
    var moreUsersArray = [UserModel]()
    var searchController = UISearchController()
    let loadingIndicator = UIActivityIndicatorView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var usersModel = [User]()
    var visitedUserArray = [VisitedUser]()
    var searchedWordsArray = [SearchedWord]()
    let noUserslabel = UILabel()
    let findYourStuffLabel = UILabel()
    let searchGithubLabel = UILabel()
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
        networkReachability(loadingIndicator: loadingIndicator)
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
    func tableViewDelegateAndDataSourceConfig(tableViewName : UITableView) {
        tableViewName.delegate = self
        tableViewName.dataSource = self
    }
    func usersTableViewConfig() {
        tableViewDelegateAndDataSourceConfig(tableViewName: usersListTableView)
        usersListTableView.prefetchDataSource = self
        usersListTableView.register(UINib(nibName: K.usersListTableViewCell, bundle: .main), forCellReuseIdentifier: K.userListCellID)
        usersListTableView.frame = view.bounds
        loadingIndicator.backgroundColor = .black
    }
    func searchHistoryTableViewConfig() {
        tableViewDelegateAndDataSourceConfig(tableViewName: searchHistoryTableView)
        tableViewNibRegister(tableViewName: searchHistoryTableView, nibName: K.collectionViewTableViewCellID)
        tableViewNibRegister(tableViewName: searchHistoryTableView, nibName: K.recentSearchTableViewCellID)
        searchHistoryTableView.frame = view.bounds
        searchHistoryTableView.isHidden = true
    }
    func searchControllerConfig() {
        searchControllerSetup(searchController: searchController, placeHolder: "Search For Users.")
        searchController.searchBar.delegate = self
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
    func LabelConfig() {
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
   

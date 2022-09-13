//
//  BookmarksViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//
import UIKit
import Kingfisher
class BookmarksViewController: UIViewController {
    //MARK: - Props
    let searchController = UISearchController()
    var usersArray = [User]()
    var filterdUserArray = [User]()
    var reposArray = [Repo]()
    var filterdReposArray = [Repo]()
    //MARK: - IBOutlets
    @IBOutlet weak var bookmarksTableView: UITableView!
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initViewModel()
    }
    //MARK: - Main Functions
    func initView() {
        tableViewConfig()
        searchControllerConfig()
    }
    func initViewModel() {
        fetchBookmarkedUsers()
        fetchBookmarkedRepos()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        bookmarksTableView.register(UINib(nibName: K.usersListTableViewCell, bundle: nil), forCellReuseIdentifier: K.UserListCellID)
        bookmarksTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        searchControllerConfig()
        bookmarksTableView.frame = view.frame
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        //searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    //MARK: - Data Function
    func fetchBookmarkedUsers() {
        CoreDataManger.shared.fetch(entityName: User.self) { (users) in
            self.usersArray = users
            self.filterdUserArray = self.usersArray
            DispatchQueue.main.async {
                self.bookmarksTableView.reloadData()
            }
        }
    }
    func fetchBookmarkedRepos() {
        CoreDataManger.shared.fetch(entityName: Repo.self) { (repos) in
            self.reposArray = repos
            self.filterdReposArray = self.reposArray
            DispatchQueue.main.async {
                self.bookmarksTableView.reloadData()
            }
        }
    }
}

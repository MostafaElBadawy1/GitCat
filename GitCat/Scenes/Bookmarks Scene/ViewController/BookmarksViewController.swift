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
    var bookmarksViewModel = BookmarksViewModel()
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
        bookmarksTableView.frame = view.frame
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search For Bookmarked Users or Repositories."
    }
    func presentAlert (title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title:title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Data Function
    func fetchBookmarkedUsers() {
        bookmarksViewModel.fetchBookmarkedUsers()
        bookmarksViewModel.bindingData = { users , error in
            if let usersData = users {
                self.usersArray = usersData
                self.filterdUserArray = self.usersArray
                DispatchQueue.main.async {
                    self.bookmarksTableView.reloadData()
                }
            }
            if let error = error {
                self.presentAlert (title: "Error While Fetching saved Users " , message: "")
                print(error)
            }
        }
    }
    func fetchBookmarkedRepos() {
        bookmarksViewModel.fetchBookmarkedReposs()
        bookmarksViewModel.bindingReposData = { repos, error in
            if let reposData = repos {
                self.reposArray = reposData
                self.filterdReposArray = self.reposArray
                DispatchQueue.main.async {
                    self.bookmarksTableView.reloadData()
                }
            }
            if let error = error {
                self.presentAlert (title: "Error While Fetching saved Reopsitories " , message: "")
                print(error)
            }
        }
//        CoreDataManger.shared.fetch(entityName: Repo.self) { (repos) in
//            self.reposArray = repos
//            self.filterdReposArray = self.reposArray
//            DispatchQueue.main.async {
//                self.bookmarksTableView.reloadData()
//            }
//        }
    }
}

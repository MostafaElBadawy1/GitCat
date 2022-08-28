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
    var usersModel = [User]()
    let reposModel = [Repo]()
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
        fetchUsers()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        bookmarksTableView.register(UINib(nibName: K.UsersListTableViewCell, bundle: nil), forCellReuseIdentifier: K.UserListCellID)
        bookmarksTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        searchControllerConfig()
        bookmarksTableView.frame = view.frame
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
    //MARK: - Data Function
    func fetchUsers() {
        CoreDataManger.shared.fetch(entityName: User.self) { (users) in
            self.usersModel = users
            DispatchQueue.main.async {
                self.bookmarksTableView.reloadData()
            }
        }
    }
}

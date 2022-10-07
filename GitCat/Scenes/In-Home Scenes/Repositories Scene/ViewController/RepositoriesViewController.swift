//
//  RepositoriesViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
import Kingfisher
class RepositoriesViewController: UIViewController {
    //MARK: - Props
    let noReposLabel = UILabel()
    var repositoriesForUserViewModel = RepositoriesViewModel()
    var reposArray = [RepositoriesForUserModel]()
    var moreReposArray = [RepositoriesForUserModel]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var passedNameFromUserDetailsVC: String?
    var isWithSearchController = false
    var isStarredReposVC = false
    var isProfile = false
    let loadingIndicator = UIActivityIndicatorView()
    let searchController = UISearchController()
    var passedTextFromSearch: String?
    //MARK: - IBOutlets
    @IBOutlet weak var repositoriesTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
    }
    //MARK: - Main Functions
    func initView() {
        tableViewConfig()
        refreshPage()
        networkReachability(loadingIndicator: loadingIndicator)
        if isWithSearchController == true {
            searchControllerConfig()
        } else {
            return
        }
    }
    func InitViewModel() {
        if isWithSearchController == true  {
            searchRepos(for: "r")
        }
        if isProfile == true {
            fetchMyRepositories()
        }
        if isStarredReposVC == true {
            if let repoOwner = passedNameFromUserDetailsVC {
                fetchStarredRepositories(userName: repoOwner)
            }
        } else {
            if let repoOwner = passedNameFromUserDetailsVC {
                 fetchUserRepositories(repoOwner: repoOwner)
            }
        }
        if let passedText = passedTextFromSearch {
            searchRepos(for: passedText)
            searchController.searchBar.text = passedText
        }
    }
    //MARK: - View Functions
    func tableViewConfig() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.prefetchDataSource = self
        tableViewNibRegister(tableViewName: repositoriesTableView, nibName: K.repositoriesTableViewCellID)
        repositoriesTableView.frame = view.frame
        self.loadingIndicator.startAnimating()
        navigationItem.title = "Repositories"
        repositoriesTableView.rowHeight = UITableView.automaticDimension
    }
    func LabelConfig(){
        noReposLabel.text = "There aren't any repositories."
        noReposLabel.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        noReposLabel.frame =  CGRect(x: 90, y: 400, width:300, height: 50)
        self.view.addSubview(noReposLabel)
    }
    func searchControllerConfig() {
        searchControllerSetup(searchController: searchController, placeHolder: "Search For Repositories.")
        searchController.searchBar.delegate = self
    }
    func refreshPage(){
        self.repositoriesTableView.refreshControl = UIRefreshControl()
        self.repositoriesTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        InitViewModel()
        self.repositoriesTableView.reloadData()
    }
    //MARK: - Data Function
    func searchRepos(for searchWord: String) {
        self.loadingIndicator.startAnimating()
        repositoriesForUserViewModel.searchRepos(searchWord: searchWord, pageNum: 1)
        repositoriesForUserViewModel.bindingData = { [self] repos, error in
            if let repos = repos {
                self.reposArray = repos
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    if self.reposArray.count == 0 {
                        self.LabelConfig()
                    }
                }
            }
            if let error = error {
                presentAlert(title: "Error While Fetching Repositories", message: "")
                print(error)
            }
        }
    }
    func searchMoreRepos(for searchWord: String, pageNum: Int) {
        repositoriesForUserViewModel.searchRepos(searchWord: searchWord, pageNum: pageNum)
        repositoriesForUserViewModel.bindingData = { [self] repos, error in
            if let repos = repos {
                self.moreReposArray = repos
                DispatchQueue.main.async {
                    self.repositoriesTableView.tableFooterView = nil
                    self.reposArray.append(contentsOf: self.moreReposArray)
                    self.repositoriesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            }
            if let error = error {
                presentAlert(title: "Error While Fetching More Repositories", message: "")
                print(error)
            }
        }
    }
    func fetchUserRepositories(repoOwner: String) {
        loadingIndicator.startAnimating()
        repositoriesForUserViewModel.fetchUserRepositories(repoOwner: repoOwner, pageNum: 1)
        repositoriesForUserViewModel.bindingData = { [self] repos, error in
            if let repos = repos {
                self.reposArray = repos
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    if self.reposArray.count == 0 {
                        self.LabelConfig()
                    }
                }
            }
            if let error = error {
                presentAlert(title: "Error While Fetching Repositories", message: "")
                print(error)
            }
        }
    }
    func fetchMoreUserRepositories(repoOwner: String, pageNum: Int) {
        repositoriesForUserViewModel.fetchUserRepositories(repoOwner: repoOwner, pageNum: pageNum)
        repositoriesForUserViewModel.bindingData = {  repos, error in
            if let repos = repos {
                self.moreReposArray = repos
                DispatchQueue.main.async {
                    self.repositoriesTableView.tableFooterView = nil
                    self.reposArray.append(contentsOf: self.moreReposArray)
                    self.repositoriesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            }
            if let error = error {
                self.presentAlert(title: "Error While Fetching More Repositories", message: "")
                print(error)
            }
        }
    }
    func fetchStarredRepositories(userName: String) {
        loadingIndicator.startAnimating()
        repositoriesForUserViewModel.fetchUserStarredRepositories(userName: userName)
        repositoriesForUserViewModel.bindingData = { [self] repos, error in
            if let repos = repos {
                self.reposArray = repos
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                    self.self.loadingIndicator.stopAnimating()
                    if self.reposArray.count == 0 {
                        self.LabelConfig()
                    }
                }
            }
            if let error = error {
                presentAlert(title: "Error While Fetching Repositories", message: "")
                print(error)
            }
        }
    }
    func fetchMyRepositories() {
        loadingIndicator.startAnimating()
        repositoriesForUserViewModel.fetchMyRepositories()
        repositoriesForUserViewModel.bindingData = { [self] repos, error in
            if let repos = repos {
                self.reposArray = repos
                print(repos)
                DispatchQueue.main.async { 
                    self.repositoriesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    if self.reposArray.count == 0 {
                        self.LabelConfig()
                    }
                }
            }
            if let error = error {
                presentAlert(title: "Error While Fetching Your Repositories", message: "")
                print(error)
            }
        }
    }
  
}


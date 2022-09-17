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
    var pageNum = 2
    var preFetchIndex = 10
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
    let spinner = UIActivityIndicatorView()
    let searchController = UISearchController()
    var isLoggedIn: Bool {
        if TokenManager.shared.fetchAccessToken() != nil {
            return true
        }
        return false
    }
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
        networkReachability()
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
//        else {
//            if isProfile == true {
//                fetchMyRepositories()
//            } else {
//                if isStarredReposVC == true {
//                    fetchStarredRepositories(userName: repoOwner)
//                } else {
//                    fetchUserRepositories(repoOwner: repoOwner)
//                }
//            }
//        }
    }
    //MARK: - View Functions
    func tableViewConfig() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.prefetchDataSource = self
        repositoriesTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        repositoriesTableView.frame = view.frame
        self.loadingIndicator.startAnimating()
        navigationItem.title = "Repositories"
        repositoriesTableView.rowHeight = UITableView.automaticDimension
    }
    func presentAlert(title: String , message: String) {
        let alert : UIAlertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func LabelConfig(){
        noReposLabel.text = "There aren't any repositories."
        noReposLabel.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        noReposLabel.frame =  CGRect(x: 110, y: 400, width:300, height: 50)
        self.view.addSubview(noReposLabel)
    }
    func showLabel() {
        if self.reposArray.count == 0 {
            self.LabelConfig()
        }
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
            presentAlert(title: "You Are Disconnected" , message: "Please Check Your Connection!")
            loadingIndicator.startAnimating()
        }
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
                    self.showLabel()
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
                print(repos)
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.showLabel()
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
                print(repos)
                DispatchQueue.main.async {
                    self.repositoriesTableView.reloadData()
                    self.self.loadingIndicator.stopAnimating()
                    self.showLabel()
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
                    self.showLabel()
                }
            }
            if let error = error {
                presentAlert(title: "Error While Fetching Your Repositories", message: "")
                print(error)
            }
        }
    }
    //    func fetchRepos(userName: String) {
    //        Task.init {
    //            if let repos = await repositoriesForUserViewModel.fetchRepos(userName: userName, pageNum: 1) {
    //                self.reposArray = repos
    //                DispatchQueue.main.async {
    //                    self.loadingIndicator.stopAnimating()
    //                    self.repositoriesTableView.reloadData()
    //                }
    //            } else {
    //                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Repositories" , message: "", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //                self.loadingIndicator.startAnimating()
    //            }
    //        }
    //    }
    //    func fetchMoreRepos(userName: String, pageNum: Int) {
    //        Task.init {
    //            if let users = await repositoriesForUserViewModel.fetchRepos(userName: userName, pageNum: pageNum) {
    //                self.moreReposArray = users
    //                if moreReposArray.isEmpty {
    //                    spinner.stopAnimating()
    //                }
    //                DispatchQueue.main.async {
    //                    self.reposArray.append(contentsOf: self.moreReposArray)
    //                    self.repositoriesTableView.reloadData()
    //                }
    //            } else {
    //                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Repositories" , message: "", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //            }
    //        }
    //    }
    //
    //    func fetchSearchedRepos(searchKeyword: String) {
    //        Task.init {
    //            if let repos = await repositoriesForUserViewModel.searchRepos(searchKeyword: searchKeyword, pageNum: 1) {
    //                self.reposArray = repos
    //                DispatchQueue.main.async {
    //                    self.loadingIndicator.stopAnimating()
    //                    self.repositoriesTableView.reloadData()
    //                }
    //            } else {
    //                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Repositories" , message: "", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //                self.loadingIndicator.startAnimating()
    //            }
    //        }
    //    }
    //    func fetchMoreSearchedRepos(searchKeyword: String, pageNum: Int) {
    //        Task.init {
    //            if let repos = await repositoriesForUserViewModel.searchRepos(searchKeyword: searchKeyword, pageNum: pageNum) {
    //                self.moreReposArray = repos
    //                if moreReposArray.isEmpty {
    //                    spinner.stopAnimating()
    //                }
    //                DispatchQueue.main.async {
    //                    self.reposArray.append(contentsOf: self.moreReposArray)
    //                    self.repositoriesTableView.reloadData()
    //                }
    //            } else {
    //                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Repositories" , message: "", preferredStyle: .alert)
    //                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    //                self.present(alert, animated: true, completion: nil)
    //            }
    //        }
    //    }
}


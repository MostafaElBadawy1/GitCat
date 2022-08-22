//
//  RepositoriesViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
class RepositoriesViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var repositoriesForUserViewModel = RepositoriesViewModel()
    var reposArray = [RepositoriesForUserModel]()
    var moreReposArray = [RepositoriesForUserModel]()
    var searchedReposArray = [RepoItems]()
    var moreSearchedReposArray = [RepoItems]()
    var passedNameFromUserDetailsVC: String?
    var isWithSearchController = true
    let loadingIndicator = UIActivityIndicatorView()
    let spinner = UIActivityIndicatorView()
    let searchController = UISearchController()
    //MARK: - IBOutlets
    @IBOutlet weak var repositoriesTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        refreshPage()
        networkReachability()
        if isWithSearchController == true {
            searchControllerConfig()
        } else {
            return
        }
    }
    func InitViewModel(){
        if let userName = passedNameFromUserDetailsVC {
            fetchRepos(userName:"\(userName)", pageNum: 1)
        }
        if isWithSearchController == true {
            fetchSearchedRepos(userName: "m", pageNum: 1)
        } else {
            return
        }
    }
    //MARK: - View Functions
    func tableViewConfig() {
        repositoriesTableView.delegate = self
        repositoriesTableView.dataSource = self
        repositoriesTableView.prefetchDataSource = self
        repositoriesTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        repositoriesTableView.frame = view.frame
        self.loadingIndicator.startAnimating()
        //navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Repositories"
        repositoriesTableView.rowHeight = UITableView.automaticDimension
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
            let alert : UIAlertController = UIAlertController(title:"You Are Disconnected" , message: "Please Check Your Connection!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            loadingIndicator.startAnimating()
        }
    }
    func refreshPage(){
        self.repositoriesTableView.refreshControl = UIRefreshControl()
        self.repositoriesTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchRepos(userName:"\(passedNameFromUserDetailsVC!)", pageNum: 1)
        self.repositoriesTableView.reloadData()
    }
    //MARK: - Data Function
    func fetchRepos(userName: String, pageNum: Int) {
        Task.init {
            if let repos = await repositoriesForUserViewModel.fetchRepos(userName: userName, pageNum: pageNum) {
                self.reposArray = repos
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.repositoriesTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Repos" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loadingIndicator.startAnimating()
            }
        }
    }
    func fetchMoreRepos(userName: String, pageNum: Int) {
        Task.init {
            if let users = await repositoriesForUserViewModel.fetchRepos(userName: userName, pageNum: pageNum) {
                self.moreReposArray = users
                if moreReposArray.isEmpty {
                    spinner.stopAnimating()
                }
                DispatchQueue.main.async {
                    self.reposArray.append(contentsOf: self.moreReposArray)
                    self.repositoriesTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Users" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    func fetchSearchedRepos(userName: String, pageNum: Int) {
        Task.init {
            if let repos = await repositoriesForUserViewModel.searchRepos(userName: userName, pageNum: pageNum) {
                self.searchedReposArray = repos
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.repositoriesTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Repos" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loadingIndicator.startAnimating()
            }
        }
    }
    func fetchMoreSearchedRepos(userName: String, pageNum: Int) {
        Task.init {
            if let users = await repositoriesForUserViewModel.searchRepos(userName: userName, pageNum: pageNum) {
                self.moreSearchedReposArray = users
                if moreSearchedReposArray.isEmpty {
                    spinner.stopAnimating()
                }
                DispatchQueue.main.async {
                    self.searchedReposArray.append(contentsOf: self.moreSearchedReposArray)
                    self.repositoriesTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Users" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

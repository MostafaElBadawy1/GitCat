//
//  ExploreViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class ExploreViewController: UIViewController {
    //MARK: - Props
    var exploreReposArray = [RepositoriesForUserModel]()
    var moreExploreReposArray = [RepositoriesForUserModel]()
    var exploreViewModel = ExploreViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let loadingIndicator = UIActivityIndicatorView()
    let searchController = UISearchController()
    let noReposLabel = UILabel()
    //MARK: - IBOutlets
    @IBOutlet weak var exploreTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
       searchControllerConfig()
        refreshPage()
        networkReachability(loadingIndicator: loadingIndicator)
    }
    func InitViewModel(){
        fetchSearchedExploreRepos(searchWord: "a")
    }
    //MARK: - View Functions
    func tableViewConfig() {
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        exploreTableView.prefetchDataSource = self
        tableViewNibRegister(tableViewName: exploreTableView, nibName: K.exploreTableViewCellID)
        exploreTableView.frame = view.frame
        self.loadingIndicator.startAnimating()
    }
    func searchControllerConfig() {
        searchControllerSetup(searchController: searchController, placeHolder: "Search In Most Starred Repositories.")
        searchController.searchBar.delegate = self
    }
    func refreshPage() {
        self.exploreTableView.refreshControl = UIRefreshControl()
        self.exploreTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchSearchedExploreRepos(searchWord: "")
        self.exploreTableView.reloadData()
        noReposLabel.isHidden = true
    }

    func LabelConfig() {
        noReposLabel.text = "There aren't any users."
        noReposLabel.font = UIFont.boldSystemFont(ofSize: 20)
        noReposLabel.frame =  CGRect(x: 110, y: 400, width: 300, height: 50)
        self.view.addSubview(noReposLabel)
    }
    //MARK: - Data Functions
    func fetchSearchedExploreRepos(searchWord: String) {
        self.loadingIndicator.startAnimating()
        exploreViewModel.fetchData(searchWord: searchWord, pageNum: 1)
        exploreViewModel.bindingData = { [self] repos, error in
            if let repos = repos {
                self.exploreReposArray = repos
                DispatchQueue.main.async {
                    self.exploreTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            }
            if let error = error {
                presentAlert (title: "Error While Fetching Repositories" , message: "")
                print(error)
            }
        }
    }
    func fetchMoreSearchedExploreRepos(searchWord: String, pageNum: Int) {
        exploreViewModel.fetchData(searchWord: searchWord, pageNum: pageNum)
        exploreViewModel.bindingData = { reposData, error in
            if let repos = reposData {
                self.moreExploreReposArray = repos
                DispatchQueue.main.async {
                        self.exploreTableView.tableFooterView = nil
                        self.exploreReposArray.append(contentsOf: self.moreExploreReposArray)
                    self.exploreTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            }
            if let error = error {
                self.presentAlert (title: "Error While Fetching More Repositories" , message: "")
                print(error)
            }
        }
    }
}

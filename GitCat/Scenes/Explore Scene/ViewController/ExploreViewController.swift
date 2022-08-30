//
//  ExploreViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class ExploreViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var exploreReposArray = [RepoItems]()
    var moreExploreReposArray = [RepoItems]()
    var exploreViewModel = ExploreViewModel()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let loadingIndicator = UIActivityIndicatorView()
    let spinner = UIActivityIndicatorView()
    let searchController = UISearchController()
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
        //setup()
    }
    func InitViewModel(){
        fetchSearchedRepos()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        exploreTableView.delegate = self
        exploreTableView.dataSource = self
        exploreTableView.prefetchDataSource = self
        exploreTableView.register(UINib(nibName: K.ExploreTableViewCellID, bundle: .main), forCellReuseIdentifier: K.ExploreTableViewCellID)
        exploreTableView.frame = view.frame
        self.loadingIndicator.startAnimating()
        //navigationItem.largeTitleDisplayMode = .never
       // navigationItem.title = "Repositories"
        //exploreTableView.rowHeight = UITableView.automaticDimension
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        //searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.searchBar.delegate = self
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
        self.exploreTableView.refreshControl = UIRefreshControl()
        self.exploreTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchSearchedRepos()
        self.exploreTableView.reloadData()
    }
    //MARK: - Data Functions
    func fetchSearchedRepos() {
        Task.init {
            if let repos = await exploreViewModel.getExploreRepos(pageNum: 1) {
                self.exploreReposArray = repos
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.exploreTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Repositories" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loadingIndicator.startAnimating()
            }
        }
    }
    func fetchMoreSearchedRepos(pageNum: Int) {
        Task.init {
            if let repos = await exploreViewModel.getExploreRepos(pageNum: pageNum)  {
                self.moreExploreReposArray = repos
                if moreExploreReposArray.isEmpty {
                    spinner.stopAnimating()
                }
                DispatchQueue.main.async {
                    self.exploreReposArray.append(contentsOf: self.moreExploreReposArray)
                    self.exploreTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Repositories" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}

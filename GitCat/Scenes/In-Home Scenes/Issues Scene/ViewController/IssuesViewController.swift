//
//  IssuesViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class IssuesViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var issuesArray = [IssuesItems]()
    var moreIssuesArray = [IssuesItems]()
    var issuesViewModel = IssuesViewModel()
    let loadingIndicator = UIActivityIndicatorView()
    let spinner = UIActivityIndicatorView()
    let searchController = UISearchController()
    //MARK: - IBOutlets
    @IBOutlet weak var issuesTableView: UITableView!
    //MARK: - LifeCycle
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
        searchControllerConfig()
    }
    func InitViewModel(){
        fetchIssues(searchWord: "p", pageNum: 1)
    }
    //MARK: - View Functions
    func tableViewConfig() {
        issuesTableView.delegate = self
        issuesTableView.dataSource = self
        issuesTableView.prefetchDataSource = self
        issuesTableView.register(UINib(nibName: K.CommitsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.CommitsTableViewCellID)
        issuesTableView.frame = view.frame
        navigationItem.title = "Issues"
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
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
        self.issuesTableView.refreshControl = UIRefreshControl()
        self.issuesTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchIssues(searchWord: "p", pageNum: 1)
        self.issuesTableView.reloadData()
    }
    //MARK: - Data Function
    func fetchIssues(searchWord: String, pageNum: Int) {
        Task.init {
            if let issues = await issuesViewModel.fetchIssues(searchWord: searchWord, pageNum: pageNum){
                self.issuesArray = issues
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.issuesTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Issues" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loadingIndicator.startAnimating()
            }
        }
    }
    func fetchMoreIssues(searchWord: String, pageNum: Int) {
        Task.init {
            if let issues = await issuesViewModel.fetchIssues(searchWord: searchWord, pageNum: pageNum){
                self.moreIssuesArray = issues
                if moreIssuesArray.isEmpty {
                    spinner.stopAnimating()
                }
                DispatchQueue.main.async {
                    self.issuesArray.append(contentsOf: self.moreIssuesArray)
                    self.issuesTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Issues" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}

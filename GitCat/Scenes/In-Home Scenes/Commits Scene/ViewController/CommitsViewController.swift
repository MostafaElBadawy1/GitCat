//
//  CommitsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//
import UIKit
class CommitsViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var repoOwner: String?
    var repoName: String?
    var commitsArray = [CommitsModel]()
    var moreCommitsArray = [CommitsModel]()
    var commitsViewModel = CommitsViewModel()
    let loadingIndicator = UIActivityIndicatorView()
    let spinner = UIActivityIndicatorView()
    //MARK: - IBOutlets
    @IBOutlet weak var commitsTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        if let safeRepoOwner = repoOwner, let safeRepoName = repoName  {
            InitViewModel(ownerName: safeRepoOwner, repoName: safeRepoName)
        }
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        refreshPage()
        networkReachability()
    }
    func InitViewModel(ownerName: String, repoName: String){
        fetchCommits(ownerName: ownerName, repoName: repoName)
    }
    func tableViewConfig() {
        commitsTableView.delegate = self
        commitsTableView.dataSource = self
        commitsTableView.prefetchDataSource = self
        commitsTableView.register(UINib(nibName: K.CommitsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.CommitsTableViewCellID)
        commitsTableView.frame = view.frame
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
        self.commitsTableView.refreshControl = UIRefreshControl()
        self.commitsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchCommits(ownerName: repoOwner!, repoName: repoName!)
        self.commitsTableView.reloadData()
    }
    //MARK: - Data Function
    func fetchCommits(ownerName: String, repoName: String) {
        Task.init {
            if let commits = await commitsViewModel.fetchCommits(ownerName: ownerName, repoName: repoName, pageNum: 1){
                self.commitsArray = commits
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.commitsTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Commits" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loadingIndicator.startAnimating()
            }
        }
    }
    func fetchMoreCommits(ownerName: String, repoName: String, pageNum: Int) {
        Task.init {
            if let commits = await commitsViewModel.fetchCommits(ownerName: ownerName, repoName: repoName, pageNum: pageNum) {
                //                try await Task.sleep(nanoseconds: 1_000_000_000)
                self.moreCommitsArray = commits
                if moreCommitsArray.isEmpty {
                    spinner.stopAnimating()
                }
                DispatchQueue.main.async {
                    self.commitsArray.append(contentsOf: self.moreCommitsArray)
                    self.commitsTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Commits" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

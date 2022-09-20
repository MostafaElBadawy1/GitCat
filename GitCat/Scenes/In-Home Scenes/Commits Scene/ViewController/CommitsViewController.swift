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
    let nocommitsLabel = UILabel()
    //MARK: - IBOutlets
    @IBOutlet weak var commitsTableView: UITableView!
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
    }
    func InitViewModel(){
        if let owner = repoOwner, let repo = repoName {
            fetchCommits(ownerName: owner, repoName: repo)
        }
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
            presentAlert(title: "You Are Disconnected", message: "Please Check Your Connection!")
            loadingIndicator.startAnimating()
        }
    }
    func refreshPage(){
        self.commitsTableView.refreshControl = UIRefreshControl()
        self.commitsTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
       InitViewModel()
        self.commitsTableView.reloadData()
    }
    func presentAlert(title: String, message: String){
        let alert : UIAlertController = UIAlertController(title: title , message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func LabelConfig(){
        nocommitsLabel.text = "There aren't any commits."
        nocommitsLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nocommitsLabel.frame =  CGRect(x: 110, y: 400, width:300, height: 50)
        self.view.addSubview(nocommitsLabel)
    }
    func showLabel() {
        if self.commitsArray.count == 0 {
            self.LabelConfig()
        }
    }
    //MARK: - Data Function
    func fetchCommits(ownerName: String, repoName: String) {
        self.loadingIndicator.startAnimating()
        commitsViewModel.fetchCommits(ownerName: ownerName, repoName: repoName, pageNum: 1)
        commitsViewModel.bindingData = { [self] commits, error in
            if let commitsData = commits {
                self.commitsArray = commitsData
                DispatchQueue.main.async {
                    self.commitsTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.showLabel()
                }
            } else {
                presentAlert(title: "Error While Fetching Commits", message: "")
                self.loadingIndicator.startAnimating()
            }
        }
    }
    func fetchMoreCommits( ownerName: String, repoName: String, pageNum: Int) {
        commitsViewModel.fetchCommits(ownerName: ownerName, repoName: repoName, pageNum: pageNum)
        commitsViewModel.bindingData = { commits, error in
            if let commitsData = commits {
                self.moreCommitsArray = commitsData
                DispatchQueue.main.async {
                    self.commitsTableView.tableFooterView = nil
                    self.commitsArray.append(contentsOf: self.moreCommitsArray)
                    self.commitsTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                }
            } else {
                self.presentAlert(title: "Error While Fetching More Commits", message: "")
            }
        }
    }
}

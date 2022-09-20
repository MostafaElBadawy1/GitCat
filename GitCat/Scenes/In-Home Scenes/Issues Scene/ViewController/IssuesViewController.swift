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
    let noIssueslabel = UILabel()
    var passedTextFromSearch: String?
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
        fetchIssues(searchWord: "p")
        if let passedText = passedTextFromSearch {
            fetchIssues(searchWord: passedText)
            searchController.searchBar.text = passedText
        }

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
        searchController.searchBar.placeholder = "Search For Issues."
    }
    
    func createSpinnerFooter()-> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        footerView.addSubview(spinner)
        spinner.center = footerView.center
        spinner.startAnimating()
        return footerView
    }
    func LabelConfig(){
        noIssueslabel.text = "There aren't any issues."
        noIssueslabel.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        noIssueslabel.frame =  CGRect(x: 110, y: 400, width:300, height: 50)
        self.view.addSubview(noIssueslabel)
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
        self.issuesTableView.refreshControl = UIRefreshControl()
        self.issuesTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchIssues(searchWord: "p")
        self.issuesTableView.reloadData()
        noIssueslabel.isHidden = true
    }
    func presentAlert(title: String, message: String) {
        let alert : UIAlertController = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    //MARK: - Data Function
    func fetchIssues(searchWord: String) {
        self.loadingIndicator.startAnimating()
        self.issuesTableView.isHidden = true
        issuesViewModel.searchIssues(searchWord: searchWord, pageNum: pageNum)
        issuesViewModel.bindingData = { [self] issuesData, error in
            if let issues = issuesData {
                self.issuesArray = issues
                DispatchQueue.main.async {
                    self.issuesTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.issuesTableView.isHidden = false
                    if self.issuesArray.count == 0 {
                        self.LabelConfig()
                    }
                }
                if let error = error {
                    presentAlert(title: "Error While Fetching Issues", message: "")
                    print(error)
                }
            }
        }
    }
        func fetchMoreIssues(searchWord: String, pageNum: Int) {
            issuesViewModel.searchIssues(searchWord: searchWord, pageNum: pageNum)
            issuesViewModel.bindingData = { [self] issuesData, error in
                if let issues = issuesData {
                    self.moreIssuesArray = issues
                    DispatchQueue.main.async {
                        self.issuesArray.append(contentsOf: self.moreIssuesArray)
                        self.loadingIndicator.stopAnimating()
                        self.issuesTableView.reloadData()
                        self.issuesTableView.tableFooterView = nil
                    }
                }
                if let error = error {
                    presentAlert (title: "Error While Fetching More Issues", message: "")
                    print(error)
                }
            }
        }
    }

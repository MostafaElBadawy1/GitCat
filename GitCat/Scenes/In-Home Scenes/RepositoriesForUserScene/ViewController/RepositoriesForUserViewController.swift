//
//  RepositoriesForUserViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/08/2022.
//
import UIKit
class RepositoriesForUserViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var repositoriesForUserViewModel = RepositoriesForUserViewModel()
    var reposArray = [RepositoriesForUserModel]()
    var moreReposArray = [RepositoriesForUserModel]()
    var passedNameFromUserDetailsVC: String?
    let loadingIndicator = UIActivityIndicatorView()
    let spinner = UIActivityIndicatorView()
    //MARK: - IBOutlets
    @IBOutlet weak var reposTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        if let userName = passedNameFromUserDetailsVC {
            InitViewModel(userName: userName)
        }
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        //refreshPage()
        networkReachability()
    }
    func InitViewModel(userName: String){
        fetchRepos(userName:"\(userName)", pageNum: 1)
    }
    //MARK: - View Functions
    func tableViewConfig() {
        reposTableView.delegate = self
        reposTableView.dataSource = self
        reposTableView.prefetchDataSource = self
        reposTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        reposTableView.frame = view.frame
        self.loadingIndicator.startAnimating()
        //navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Repositories"
        reposTableView.rowHeight = UITableView.automaticDimension
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
        self.reposTableView.refreshControl = UIRefreshControl()
        self.reposTableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc private func refreshData() {
        fetchRepos(userName:"\(passedNameFromUserDetailsVC!)", pageNum: 1)
        self.reposTableView.reloadData()
    }
    //MARK: - Data Function
    func fetchRepos(userName: String, pageNum: Int) {
        Task.init {
            if let repos = await repositoriesForUserViewModel.fetchRepos(userName: userName, pageNum: pageNum) {
                self.reposArray = repos
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.reposTableView.reloadData()
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
                //                try await Task.sleep(nanoseconds: 1_000_000_000)
                self.moreReposArray = users
                if moreReposArray.isEmpty {
                    spinner.stopAnimating()
                }
                DispatchQueue.main.async {
                    self.reposArray.append(contentsOf: self.moreReposArray)
                    self.reposTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Users" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
extension RepositoriesForUserViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 110
//        //cell.repoNameLabel.heightAnchor + cell.repoDescriptionLabel.heightAnchor + cell.starredNumberLabel.heightAnchor
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reposArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        reposTableView.deselectRow(at: indexPath, animated: true)
        //        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.CommitsViewControllerID) as! CommitsViewController
        //        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = reposTableView.dequeueReusableCell(withIdentifier: K.RepositoriesTableViewCellID, for: indexPath) as! RepositoriesTableViewCell
        cell.repoNameLabel.text = reposArray[indexPath.row].name
        cell.repoDescriptionLabel.text = reposArray[indexPath.row].description
        if reposArray[indexPath.row].description == "" {
            cell.repoDescriptionLabel.isHidden = true
        }
        cell.starredNumberLabel.text = "\(reposArray[indexPath.row].stargazers_count)"
        cell.programmingLangLabel.text = reposArray[indexPath.row].language
        return cell
    }
}
extension RepositoriesForUserViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == preFetchIndex {
                preFetchIndex = preFetchIndex + 30
                pageNum = pageNum + 1
                self.reposTableView.tableFooterView = createSpinnerFooter()
                fetchMoreRepos(userName: "\(passedNameFromUserDetailsVC!)", pageNum: pageNum)
            }
        }
    }
}

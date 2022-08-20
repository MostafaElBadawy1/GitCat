//
//  UsersSearchResultViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 16/08/2022.
//

import UIKit
import Kingfisher
class UsersSearchResultViewController: UIViewController {
    //MARK: - Props
    var pageNum = 1
    var preFetchIndex = 15
    var usersSearchResultViewModel = UsersSearchResultViewModel()
    var usersArray = [Items]()
    var moreUsersArray = [Items]()
    let loadingIndicator = UIActivityIndicatorView()
    //MARK: - IBOutlets
    @IBOutlet weak var usersResultTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        usersResultTableView.delegate = self
//        usersResultTableView.dataSource = self
        initView()
        InitViewModel()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //networkReachability()
    }
    //MARK: - Main Functions
    func initView(){
       // tableViewConfig()
    }
    func InitViewModel(){
//        fetchUser(searchKeyword: "mo", page: 1)
    }
    //MARK: - View Functions
    func tableViewConfig() {
        usersResultTableView.delegate = self
        usersResultTableView.dataSource = self
        usersResultTableView.prefetchDataSource = self
        usersResultTableView.register(UINib(nibName: K.UsersListTableViewCell, bundle: .main), forCellReuseIdentifier: K.UserListCellID)
        usersResultTableView.frame = view.frame
       // self.usersResultTableView.tableFooterView = createSpinnerFooter()
    }
//    func createSpinnerFooter()-> UIView {
//        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
//        let spinner = UIActivityIndicatorView()
//        footerView.addSubview(spinner)
//        spinner.center = footerView.center
//        if usersArray.isEmpty {
//            spinner.stopAnimating()
//        } else {
//            spinner.startAnimating()
//        }
//        return footerView
//    }
//    func networkReachability(){
//        loadingIndicator.style = .medium
//        loadingIndicator.center = view.center
//        view.addSubview(loadingIndicator)
//        if NetworkMonitor.shared.isConnected {
//            loadingIndicator.stopAnimating()
//        } else {
//            let alert : UIAlertController = UIAlertController(title:"You Are Disconnected" , message: "Please Check Your Connection!", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//            loadingIndicator.startAnimating()
//        }
//    }
    //MARK: - Data Function
    func fetchUser(searchKeyword: String, page: Int) {
        Task.init {
            if let users = await usersSearchResultViewModel.fetchAllUsers(searchKeyword: searchKeyword, page: page) {
                self.usersArray = users
                DispatchQueue.main.async {
                    self.loadingIndicator.stopAnimating()
                    self.usersResultTableView.reloadData()
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Users" , message: "Please Check Your Connection !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
//    func fetchMoreUsers(searchKeyword: String, page: Int) {
//        Task.init {
//            if let users = await usersSearchResultViewModel.fetchAllUsers(searchKeyword: searchKeyword, page: page) {
//                //                try await Task.sleep(nanoseconds: 1_000_000_000)
//                self.moreUsersArray = users
//                DispatchQueue.main.async {
//                    self.usersArray.append(contentsOf: self.moreUsersArray)
//                    self.usersResultTableView.reloadData()
//                }
//            } else {
//                let alert : UIAlertController = UIAlertController(title:"Error While Fetching More Users" , message: "Please Check Your Connection!", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
}

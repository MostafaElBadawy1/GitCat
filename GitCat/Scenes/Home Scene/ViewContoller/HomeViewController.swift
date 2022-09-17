//
//  HomeViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 04/08/2022.
//
import UIKit
import Kingfisher
class HomeViewController: UIViewController {
    //MARK: - Props
    let searchController = UISearchController()
    var homeViewModel = HomeViewModel()
    let homeArray = [["Users", "Repositories", "Issues", "Github Web"], ["My Repo"],["Authenticated User Mode"]]
    let imagesArray = [UIImage(named: "UsersIcon"),UIImage(named: "repoIcon"),UIImage(named: "issuesIcon"),UIImage(named: "GitHubIcon")]
    var myRepoModel : RepositoriesForUserModel?
    var isLoggedIn: Bool {
        if TokenManager.shared.fetchAccessToken() != nil {
            return true
        }
        return false
    }
    //MARK: - IBOutlets
    @IBOutlet weak var homeTableView: UITableView!
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
        //        UINavigationController(rootViewController: HomeViewController())
    }
    //MARK: - Main Functions
    func initView() {
        tableViewConfig()
        searchControllerConfig()
    }
    func initViewModel() {
        fetchMyRepo()
    }
    //MARK: - View Functions
    func tableViewConfig() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        self.homeTableView.isHidden = true
        //        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 110))
        //        homeTableView.tableHeaderView = header
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.searchBar.returnKeyType = .done
        
        // Monitor when the search controller is presented and dismissed.
        searchController.delegate = self
        
        // Monitor when the search button is tapped, and start/end editing.
        searchController.searchBar.delegate = self
    }
    //MARK: - Data Functions
    func fetchMyRepo() {
        homeViewModel.fetchMyRepo()
        homeViewModel.bindingData = { repo, error in
            if let myRepo = repo {
                self.myRepoModel = myRepo
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                    self.homeTableView.isHidden = false
                }
                } else {
                    print(error)
                    // if error != nil {
                    let alert : UIAlertController = UIAlertController(title:"Error While Fetching Your Repo Name And Image" , message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print(error!)
                }
            }
        }
    }

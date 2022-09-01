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
    var myRepoModel : MyRepo?
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
        appAppearanceConfig()
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
    func appAppearanceConfig() {
        let window = UIApplication.shared.windows[0]
        if UserDefaults.standard.bool(forKey: "isDarkMode") == true {
            window.overrideUserInterfaceStyle = .dark
        } else {
            window.overrideUserInterfaceStyle = .light
        }
    }
    //MARK: - Data Functions
    func fetchMyRepo() {
        Task.init {
            if let user = await homeViewModel.fetchMyRepo() {
                self.myRepoModel = user
                DispatchQueue.main.async {
                    self.homeTableView.reloadData()
                    self.homeTableView.isHidden = false
                }
            } else {
                let alert : UIAlertController = UIAlertController(title:"Error While Fetching Your Repo Name And Image" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }

}



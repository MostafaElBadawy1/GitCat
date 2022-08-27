//
//  HomeViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 04/08/2022.
//
import UIKit
class HomeViewController: UIViewController {
    let searchController = UISearchController()
    let homeArray = [["Users", "Repositories", "Issues", "Github Web"], ["My Repo"],["Authenticated User Mode"]]
    let imagesArray = [UIImage(named: "UsersIcon"),UIImage(named: "repoIcon"),UIImage(named: "issuesIcon"),UIImage(named: "GitHubIcon")]
    @IBOutlet weak var homeTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        searchControllerConfig()
        appAppearanceConfig()
//        UINavigationController(rootViewController: HomeViewController())
    }
    func tableViewConfig() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
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
}



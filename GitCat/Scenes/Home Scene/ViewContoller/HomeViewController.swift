//
//  HomeViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 04/08/2022.
//

import UIKit
class resultsTableController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

class HomeViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: resultsTableController())
    let homeArray = [["Users", "Repositories", "Issues", "Github Web"], ["My Repo"],["Authenticated User Mode"]]
    let imagesArray = [UIImage(named: "UsersIcon"),UIImage(named: "repoIcon"),UIImage(named: "issuesIcon"),UIImage(named: "GitHubIcon")]
    @IBOutlet weak var homeTableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        tableViewConfig()
        searchControllerConfig()
//        UINavigationController(rootViewController: HomeViewController())

    }
    func tableViewConfig() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
//        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 110))
//        homeTableView.tableHeaderView = header
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }

}



//
//  BookmarksViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit

class BookmarksViewController: UIViewController {
    let searchController = UISearchController(searchResultsController: resultsTableController())
    @IBOutlet weak var bookmarksTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        searchControllerConfig()
    }
    func tableViewConfig() {
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        bookmarksTableView.register(UINib(nibName: K.UsersListTableViewCell, bundle: nil), forCellReuseIdentifier: K.UserListCellID)
        bookmarksTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        searchControllerConfig()
        bookmarksTableView.frame = view.frame
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }
}

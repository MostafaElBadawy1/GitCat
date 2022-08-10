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
        bookmarksTableView.delegate = self
        bookmarksTableView.dataSource = self
        bookmarksTableView.register(UINib(nibName: K.UsersListTableViewCell, bundle: nil), forCellReuseIdentifier: K.UserListCellID)
        bookmarksTableView.register(UINib(nibName: K.RepositoriesTableViewCellID, bundle: .main), forCellReuseIdentifier: K.RepositoriesTableViewCellID)
        searchControllerConfig()
    }
    func searchControllerConfig() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
    }


}
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let titleView = view as! UITableViewHeaderFooterView
        titleView.textLabel?.text = titleView.textLabel?.text?.localizedCapitalized
        titleView.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Users"
        } else {
            return "Reopsitories"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 110
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookmarksTableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        
        if indexPath.section == 0  {
            let userCell = bookmarksTableView.dequeueReusableCell(withIdentifier: K.UserListCellID, for: indexPath) as! UsersListTableViewCell
            return userCell
        } else {
            let repoCell = bookmarksTableView.dequeueReusableCell(withIdentifier: K.RepositoriesTableViewCellID, for: indexPath)
            return repoCell
        }
    }
    
    
}
extension BookmarksViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        print(text)
    }
}

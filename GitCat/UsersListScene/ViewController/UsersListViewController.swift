//
//  UsersListViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import UIKit

class UsersListViewController: UIViewController {
    //MARK: - Props
    var usersViewModel = UsersListViewModel()
    var usersArray: [Users] = []
    var filteredArray: [Users] = []
    //MARK: - IBOutlets
    @IBOutlet weak var usersSearchBar: UISearchBar!
    @IBOutlet weak var usersListTableView: UITableView!
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        InitViewModel()
    }
    //MARK: - Main Functions
    func initView(){
        tableViewConfig()
        searchBarConfig()
    }
    func InitViewModel(){
        fetchUsers()
    }
    func tableViewConfig() {
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.register(UINib(nibName: "UsersListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
    }
    func searchBarConfig() {
        usersSearchBar.delegate = self
    }
    func fetchUsers() {
        usersViewModel.fetchAllUsers()
        usersViewModel.bindingData = { users, error in
            if let users = users {
                self.usersArray = users
                DispatchQueue.main.async {
                    self.usersListTableView.reloadData()
                }
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
        }
}
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(usersArray.count)
        return usersArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersListTableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UsersListTableViewCell
        cell.userNameLabel.text = usersArray[indexPath.row].login
        return cell
    }
}
extension UsersListViewController: UISearchBarDelegate {
    
}

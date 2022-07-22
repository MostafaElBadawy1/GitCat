//
//  UsersListViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 20/07/2022.
//

import UIKit
import Kingfisher
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
    //MARK: - View Functions
    func tableViewConfig() {
        usersListTableView.delegate = self
        usersListTableView.dataSource = self
        usersListTableView.register(UINib(nibName: "UsersListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
    }
    func searchBarConfig() {
        usersSearchBar.delegate = self
    }
    //MARK: - Data Function
    func fetchUsers() {
        usersViewModel.fetchAllUsers()
        usersViewModel.bindingData = { users, error in
            if let users = users {
                self.usersArray = users
                self.filteredArray = self.usersArray
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
//MARK: - TableView
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersListTableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UsersListTableViewCell
        cell.userNameLabel.text = filteredArray[indexPath.row].login
        cell.userImage.kf.setImage(with: URL(string: "https://play.google.com/store/apps/details?id=com.olzhas.carparking.multyplayer&hl=ar&gl=US"))
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
//MARK: - SearchBar
extension UsersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredArray = usersArray
            self.usersListTableView.reloadData()
        } else {
            filteredArray = usersArray.filter({ user in
                return user.login!.contains(searchText.lowercased())
            })
            self.usersListTableView.reloadData()
        }
    }
}

//
//  UsersListViewController+TableView-Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//
import UIKit
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      switch tableView {
        case searchHistoryTableView:
            return 10
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case usersListTableView:
            return 70
        case searchHistoryTableView:
            switch indexPath.section {
            case 0:
                return 130
            default:
                return 50
            }
        default:
            return 70
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case usersListTableView:
            return 1
        case searchHistoryTableView:
            return 2
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case usersListTableView:
            return usersArray.count
        case searchHistoryTableView:
            switch section {
            case 0:
                return 1
            case 1:
               return searchedWordsArray.count
            default:
                return 0
            }
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case searchHistoryTableView:
            let recentVisitedUsersCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.CollectionViewTableViewCellID) as! CollectionViewTableViewCell
            let searchWordCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.RecentSearchTableViewCellID) as! RecentSearchTableViewCell
            switch indexPath.section {
            case 0:
                recentVisitedUsersCell.delegate = self
                recentVisitedUsersCell.index = indexPath
                return recentVisitedUsersCell
            default:
                searchWordCell.recentSearchLabel.text = searchedWordsArray[indexPath.row].word
                return searchWordCell
            }
        default:
            let userCell = usersListTableView.dequeueReusableCell(withIdentifier: K.UserListCellID, for: indexPath) as! UsersListTableViewCell
            userCell.userNameLabel.text = usersArray[indexPath.row].login
            userCell.UserImageView.kf.setImage(with: URL(string: usersArray[indexPath.row].avatar_url!),placeholder: UIImage(named: "UsersIcon"))
            userCell.UserImageView.layer.masksToBounds = false
            userCell.UserImageView.layer.cornerRadius = userCell.UserImageView.frame.height/2
            userCell.UserImageView.clipsToBounds = true
            return userCell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch tableView {
        case usersListTableView:
            usersListTableView.deselectRow(at: indexPath, animated: true)
            let passedDataToUserDetailsVC = usersArray[indexPath.row].login
            let userDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.UserDetailsViewControllerID) as! UserDetailsViewController
            userDetailsVC.passeedDataFromUserListVC = passedDataToUserDetailsVC
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
            if searchController.isActive {
                let visitedUser = VisitedUser(context: self.context)
                visitedUser.userName = usersArray[indexPath.row].login
                visitedUser.userImageURL = URL(string: usersArray[indexPath.row].avatar_url!)
                do {
                    try self.context.save()
                } catch {
                    presentAlert(title: "Error While Saving Search Visited User", message: "")
                }
            }
        case searchHistoryTableView:
            searchHistoryTableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.section {
            case 0:
                break
            case 1:
                fetchUsers(for: searchedWordsArray[indexPath.row].word!)
                searchController.searchBar.text = searchedWordsArray[indexPath.row].word!
                usersListTableView.isHidden = false
                searchHistoryTableView.isHidden = true
            default:
               break
            }
        default:
            break
        }
        }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == searchHistoryTableView && indexPath.section == 1 {
           return .delete
        }  else {
            return .none
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if indexPath.section == 1 {
                let searchedWords = searchedWordsArray[indexPath.row]
                CoreDataManger.shared.delete(entityName: SearchedWord.self, delete: searchedWords)
                CoreDataManger.shared.fetch(entityName: SearchedWord.self) { (word, error) in
                    if let word = word {
                        self.searchedWordsArray = word
                        DispatchQueue.main.async {
                            self.searchHistoryTableView.reloadData()
                        }
                    }
                    if let error = error {
                        self.presentAlert (title: "Error While Deleting User " , message: "")
                        print(error)
                    }
                }
            }
//            } else {
//                let item = filterdReposArray[indexPath.row]
//                CoreDataManger.shared.delete(entityName: Repo.self, delete: item)
//                // fetchBookmarkedRepos()
//                CoreDataManger.shared.fetch(entityName: Repo.self) { (item, error) in
//                    if let item = item {
//                        self.filterdReposArray = item
//                        DispatchQueue.main.async {
//                            self.bookmarksTableView.reloadData()
//                        }
//                    }
//
//                    if let error = error {
//                        self.presentAlert (title: "Error While Deleting Repo " , message: "")
//                        print(error)
//                    }
//                }
//            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

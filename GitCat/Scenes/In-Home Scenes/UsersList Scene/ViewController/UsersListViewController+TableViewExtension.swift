//
//  UsersListViewController+TableView-Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//
import UIKit
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case usersListTableView:
            return 70
        case searchHistoryTableView:
            switch indexPath.section {
            case 0:
                return 120
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
            let recentVisitedUsersCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.collectionViewTableViewCellID) as! CollectionViewTableViewCell
            let searchWordCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.recentSearchTableViewCellID) as! RecentSearchTableViewCell
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
            let userCell = usersListTableView.dequeueReusableCell(withIdentifier: K.userListCellID, for: indexPath) as! UsersListTableViewCell
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
            let userDetailsVC = UIStoryboard(name: "Users", bundle: nil).instantiateViewController(withIdentifier: K.userDetailsViewControllerID) as! UserDetailsViewController
            userDetailsVC.passeedDataFromUserListVC = passedDataToUserDetailsVC
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
            if searchController.isActive {
                let visitedUser = VisitedUser(context: self.context)
                visitedUser.userName = usersArray[indexPath.row].login
                visitedUser.userImageURL = URL(string: usersArray[indexPath.row].avatar_url!)
                do {
                    try self.context.save()
                } catch {
                    self.context.reset()
                    print(error)
                }
            }
        case searchHistoryTableView:
            searchHistoryTableView.deselectRow(at: indexPath, animated: true)
            switch indexPath.section {
            case 0:
                break
            case 1:
                if let searchWord = searchedWordsArray[indexPath.row].word {
                    fetchUsers(for: searchWord)
                    searchController.searchBar.text = searchWord
                }
                
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
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

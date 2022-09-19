//
//  HomeViewController+TableViewExt.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 05/08/2022.
//
import UIKit
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case homeTableView:
            return 50
        case searchHistoryTableView:
            switch indexPath.section {
            case 0:
                return 130
            default:
                return 50
            }
        default:
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch tableView {
        case homeTableView:
            return 50
        case searchHistoryTableView:
            return 10
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == homeTableView {
            switch section
            {
            case 0:
                return "Features"
            case 1:
                return "Repo"
            default:
                return "State"
            }
        } else {
            return nil
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let titleView = view as! UITableViewHeaderFooterView
        titleView.textLabel?.text = titleView.textLabel?.text?.localizedCapitalized
        titleView.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        switch tableView {
        case homeTableView:
            return homeArray.count
        case searchHistoryTableView:
            return 2
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case homeTableView:
            return homeArray[section].count
        case searchHistoryTableView:
            if section == 1 {
                return searchedWordsArray.count
            } else {
                return 1
            }
        case navigatingSearchTableView:
            return 4
        default:
            break
        }
        return 4
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch tableView {
            case homeTableView:
                homeTableView.deselectRow(at: indexPath, animated: true)
                if indexPath.section == 0 && indexPath.row == 0 {
                    let usersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.usersListViewControllerID) as! UsersListViewController
                    self.navigationController?.pushViewController(usersVC, animated: true)
                } else if indexPath.section == 0 && indexPath.row == 1 {
                    let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.RepositoriesViewControllerID) as! RepositoriesViewController
                    reposVC.isWithSearchController = true
                    self.navigationController?.pushViewController(reposVC, animated: true)
                } else if indexPath.section == 0 && indexPath.row == 2 {
                    let issuesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.IssuesViewControllerID) as! IssuesViewController
                    self.navigationController?.pushViewController(issuesVC, animated: true)
                } else if indexPath.section == 0 && indexPath.row == 3 {
                    let webViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.WebViewViewControllerID) as! WebViewViewController
                    self.navigationController?.pushViewController(webViewVC, animated: true)
                } else if indexPath.section == 1 && indexPath.row == 0 {
                    let webViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.WebViewViewControllerID) as! WebViewViewController
                    webViewVC.isMyRepo = true
                    self.navigationController?.pushViewController(webViewVC, animated: true)
                }
            case searchHistoryTableView:
                searchHistoryTableView.deselectRow(at: indexPath, animated: true)
                if indexPath.section == 1 {
                    navigatingSearchTableViewConfig()
                    homeTableView.isHidden = true
                    searchHistoryTableView.isHidden = true
                    navigatingSearchTableView.isHidden = false
                   // query = searchedWordsArray[indexPath.row].word
                    searchController.searchBar.text = searchedWordsArray[indexPath.row].word
                }
            case navigatingSearchTableView:
                navigatingSearchTableView.deselectRow(at: indexPath, animated: true)
                switch indexPath.row {
                case 0:
                    let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.RepositoriesViewControllerID) as! RepositoriesViewController
                    reposVC.isWithSearchController = true
                    reposVC .passedTextFromSearch = query
                    self.navigationController?.pushViewController(reposVC, animated: true)
                case 1:
                    let issuesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.IssuesViewControllerID) as! IssuesViewController
                    issuesVC.passedTextFromSearch = query
                    self.navigationController?.pushViewController(issuesVC, animated: true)
                case 2:
                    let usersVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.usersListViewControllerID) as! UsersListViewController
                    usersVC.passedTextFromSearch = query
                    self.navigationController?.pushViewController(usersVC, animated: true)
                case 3:
                    let orgsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.OrganizationsViewControllerID) as! OrganizationsViewController
                    orgsVC.passedNameFromUserDetailsVC = query
                    self.navigationController?.pushViewController(orgsVC, animated: true)
                default:
                    break
                }
            default:
                break
            }
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == homeTableView {
            let cell = homeTableView.dequeueReusableCell(withIdentifier: K.homeTableViewCell , for: indexPath) as! HomeTableViewCell
            switch indexPath.section {
            case 0:
                cell.accessoryType = .disclosureIndicator
                cell.homeImage.isHidden = false
                cell.homeLabel.text = homeArray[indexPath.section][indexPath.row]
                cell.homeImage.image = imagesArray[indexPath.row]
            case 1:
                if let repoName = myRepoModel?.name {
                    cell.homeLabel.text = repoName
                }
                if let userAvatarUrl = myRepoModel?.owner?.avatar_url {
                    cell.homeImage.kf.setImage(with: URL(string: "\(userAvatarUrl)"),placeholder: UIImage(named: "UsersIcon"))
                }
                cell.homeImage.layer.masksToBounds = false
                cell.homeImage.layer.cornerRadius = cell.homeImage.frame.height/2
                cell.homeImage.clipsToBounds = true
            case 2:
                cell.selectionStyle = .none
                if isLoggedIn == false {
                    cell.homeLabel.text = "Guest Mode"
                } else {
                    cell.homeLabel.text = "Authenticated User Mode"
                }
                cell.homeImage.isHidden = true
                cell.accessoryType = .none
            default:
                break
            }
            return cell
        } else {
            if tableView == searchHistoryTableView {
                let recentVisitedUsersCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.CollectionViewTableViewCellID) as! CollectionViewTableViewCell
                let searchWordCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.RecentSearchTableViewCellID) as! RecentSearchTableViewCell
                switch indexPath.section {
                case 0:
                    recentVisitedUsersCell.delegate = self
                    recentVisitedUsersCell.index = indexPath
                    return recentVisitedUsersCell
                case 1:
                    searchWordCell.recentSearchLabel.text = searchedWordsArray[indexPath.row].word
                    return searchWordCell
                default:
                    break
                }
            } else {
                let navigatingSearchCell = navigatingSearchTableView.dequeueReusableCell(withIdentifier: K.navigatingSearchTableViewCell) as! NavigatingSearchTableViewCell
                if let typedWord = query {
                    switch indexPath.row {
                    case 0 :
                        navigatingSearchCell.navigatingLabel.text = "Repositories with \"\(typedWord)\""
                    case 1 :
                        navigatingSearchCell.navigatingLabel.text = "Issues with \"\(typedWord)\""
                    case 2 :
                        navigatingSearchCell.navigatingLabel.text = "People with \"\(typedWord)\""
                    case 3 :
                        navigatingSearchCell.navigatingLabel.text = "Organizations with \"\(typedWord)\""
                    default:
                        break
                    }
                }
                return navigatingSearchCell
            }
        }
        let cell = homeTableView.dequeueReusableCell(withIdentifier: K.homeTableViewCell , for: indexPath) as! HomeTableViewCell
        return cell
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
    extension HomeViewController: CollectionViewTableViewCellDelegate {
        func tappedCell(cell: CollectionViewTableViewCell, index: Int) {
            let userDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.UserDetailsViewControllerID) as! UserDetailsViewController
            userDetailsVC.passeedDataFromUserListVC = visitedUserArray[index].userName
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
        }
    }

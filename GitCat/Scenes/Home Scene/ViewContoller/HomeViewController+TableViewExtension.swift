//
//  HomeViewController+TableViewExt.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 05/08/2022.
//
import UIKit
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == navigatingSearchTableView {
            return 0
        } else if tableView == searchHistoryTableView {
                return 30
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == homeTableView {
            switch section {
            case 0:
                return "Features"
            case 1:
                return "Repo"
            default:
                return "State"
            }
        } else if tableView == searchHistoryTableView {
            return "Recent Search"
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
        default:
            return 1
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case homeTableView:
            return homeArray[section].count
        case searchHistoryTableView:
            return searchedWordsArray.count
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
                    let usersVC = UIStoryboard(name: "Users", bundle: nil).instantiateViewController(withIdentifier: K.usersListViewControllerID) as! UsersListViewController
                    self.navigationController?.pushViewController(usersVC, animated: true)
                } else if indexPath.section == 0 && indexPath.row == 1 {
                    let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.repositoriesViewControllerID) as! RepositoriesViewController
                    reposVC.isWithSearchController = true
                    self.navigationController?.pushViewController(reposVC, animated: true)
                } else if indexPath.section == 0 && indexPath.row == 2 {
                    let issuesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.issuesViewControllerID) as! IssuesViewController
                    self.navigationController?.pushViewController(issuesVC, animated: true)
                } else if indexPath.section == 0 && indexPath.row == 3 {
                    let webViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.webViewViewControllerID) as! WebViewViewController
                    self.navigationController?.pushViewController(webViewVC, animated: true)
                } else if indexPath.section == 1 && indexPath.row == 0 {
                    let webViewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.webViewViewControllerID) as! WebViewViewController
                    webViewVC.isMyRepo = true
                    self.navigationController?.pushViewController(webViewVC, animated: true)
                }
            case searchHistoryTableView:
                searchHistoryTableView.deselectRow(at: indexPath, animated: true)
                    navigatingSearchTableViewConfig()
                    homeTableView.isHidden = true
                    searchHistoryTableView.isHidden = true
                    navigatingSearchTableView.isHidden = false
                    searchController.searchBar.text = searchedWordsArray[indexPath.row].word
            case navigatingSearchTableView:
                navigatingSearchTableView.deselectRow(at: indexPath, animated: true)
                if searchController.isActive {
                    guard let text = searchController.searchBar.text else { return }
                    let searchWord = SearchedWord(context: self.context)
                    searchWord.word = text
                    if text.isEmpty  {
                        return
                    } else {
                        do {
                            try self.context.save()
                        } catch {
                            self.context.reset()
                            print(error)
                        }
                    }
                }
                switch indexPath.row {
                case 0:
                    let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.repositoriesViewControllerID) as! RepositoriesViewController
                    reposVC.isWithSearchController = true
                    reposVC .passedTextFromSearch = query
                    self.navigationController?.pushViewController(reposVC, animated: true)
                case 1:
                    let issuesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.issuesViewControllerID) as! IssuesViewController
                    issuesVC.passedTextFromSearch = query
                    self.navigationController?.pushViewController(issuesVC, animated: true)
                case 2:
                    let usersVC = UIStoryboard(name: "Users", bundle: nil).instantiateViewController(withIdentifier: K.usersListViewControllerID) as! UsersListViewController
                    usersVC.passedTextFromSearch = query
                    self.navigationController?.pushViewController(usersVC, animated: true)
                case 3:
                    let orgsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.organizationsViewControllerID) as! OrganizationsViewController
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
                if homeViewModel.isLoggedIn == false {
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
                let searchWordCell = searchHistoryTableView.dequeueReusableCell(withIdentifier: K.recentSearchTableViewCellID) as! RecentSearchTableViewCell
                    searchWordCell.recentSearchLabel.text = searchedWordsArray[indexPath.row].word
                    return searchWordCell
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
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if tableView == searchHistoryTableView && indexPath.section == 0 {
           return .delete
        }  else {
            return .none
        }
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
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
                        self.context.reset()
                        self.presentAlert (title: "Error While Deleting Search Word " , message: "")
                        print(error)
                    }
                }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
   

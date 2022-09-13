//
//  HomeViewController+TableViewExt.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 05/08/2022.
//
import UIKit
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section
        {
        case 0:
            return "Features"
        case 1:
            return "Repo"
        default:
            return "State"
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let titleView = view as! UITableViewHeaderFooterView
        titleView.textLabel?.text = titleView.textLabel?.text?.localizedCapitalized
        titleView.textLabel?.font = UIFont.boldSystemFont(ofSize: 19)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeArray.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeArray[section].count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: K.homeTableViewCell , for: indexPath) as! HomeTableViewCell
        switch indexPath.section {
        case 0:
            cell.accessoryType = .disclosureIndicator
            cell.homeImage.isHidden = false
            cell.homeLabel.text = homeArray[indexPath.section][indexPath.row]
            cell.homeImage.image = imagesArray[indexPath.row]
        case 1:
            cell.homeLabel.text = myRepoModel?.name!
            if let userAvatarUrl = myRepoModel?.owner?.avatar_url! {
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
    }
}


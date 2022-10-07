//
//  BookmarksViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//
import UIKit
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
        switch section {
        case 0:
            return filterdUserArray.count
        case 1:
            return filterdReposArray.count
        default:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        bookmarksTableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            let userDetailsVC = UIStoryboard(name: "Users", bundle: nil).instantiateViewController(withIdentifier: K.userDetailsViewControllerID) as! UserDetailsViewController
            userDetailsVC.passeedDataFromUserListVC = filterdUserArray[indexPath.row].userName
            userDetailsVC.isSaved = true
            self.navigationController?.pushViewController(userDetailsVC, animated: true)
        case 1:
            let commitsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.commitsViewControllerID) as! CommitsViewController
            commitsVC.repoName = filterdReposArray[indexPath.row].repoName!
            commitsVC.repoOwner = filterdReposArray[indexPath.row].ownerName!
            self.navigationController?.pushViewController(commitsVC, animated: true)
        default:
            break
            
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            let userCell = bookmarksTableView.dequeueReusableCell(withIdentifier: K.userListCellID, for: indexPath) as! UsersListTableViewCell
            userCell.userNameLabel.text = filterdUserArray[indexPath.row].userName
            if let userAvatarUrl = filterdUserArray[indexPath.row].userImageURL{
                userCell.UserImageView.kf.setImage(with: userAvatarUrl, placeholder: UIImage(named: "UsersIcon"))
            }
            userCell.UserImageView.layer.masksToBounds = false
            userCell.UserImageView.layer.cornerRadius = userCell.UserImageView.frame.height/2
            userCell.UserImageView.clipsToBounds = true
            return userCell
        } else  {
            let repoCell = bookmarksTableView.dequeueReusableCell(withIdentifier: K.repositoriesTableViewCellID, for: indexPath) as! RepositoriesTableViewCell
            repoCell.repoNameLabel.text = filterdReposArray[indexPath.row].repoFullName
            repoCell.repoDescriptionLabel.text = filterdReposArray[indexPath.row].repoDescription
            repoCell.programmingLangLabel.text = filterdReposArray[indexPath.row].repoLanguage
            repoCell.starredNumberLabel.text = "\(filterdReposArray[indexPath.row].starredNum)"
            repoCell.repoImageView.kf.setImage(with: filterdReposArray[indexPath.row].repoImageUrl ,placeholder: UIImage(named: "repoIcon"))
            repoCell.repoImageView.layer.masksToBounds = false
            repoCell.repoImageView.layer.cornerRadius = repoCell.repoImageView.frame.height/2
            repoCell.repoImageView.clipsToBounds = true
            repoCell.languageIndicator.isHidden = true
            return repoCell
        }
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            if indexPath.section == 0 {
                let userItem = filterdUserArray[indexPath.row]
                CoreDataManger.shared.delete(entityName: User.self, delete: userItem)
                CoreDataManger.shared.fetch(entityName: User.self) { (item, error) in
                    if let item = item {
                        self.filterdUserArray = item
                        DispatchQueue.main.async {
                            self.bookmarksTableView.reloadData()
                        }
                    }
                    if let error = error {
                        self.presentAlert (title: "Error While Deleting User " , message: "")
                        print(error)
                    }
                }
            } else {
                let item = filterdReposArray[indexPath.row]
                CoreDataManger.shared.delete(entityName: Repo.self, delete: item)
                CoreDataManger.shared.fetch(entityName: Repo.self) { (item, error) in
                    if let item = item {
                        self.filterdReposArray = item
                        DispatchQueue.main.async {
                            self.bookmarksTableView.reloadData()
                        }
                    }
                    if let error = error {
                        self.presentAlert (title: "Error While Deleting Repo " , message: "")
                        print(error)
                    }
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

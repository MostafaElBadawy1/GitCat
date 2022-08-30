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
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0  {
            let userCell = bookmarksTableView.dequeueReusableCell(withIdentifier: K.UserListCellID, for: indexPath) as! UsersListTableViewCell
            userCell.userNameLabel.text = usersArray[indexPath.row].userName
            if let userAvatarUrl = usersArray[indexPath.row].userImageURL{
                userCell.UserImageView.kf.setImage(with: userAvatarUrl, placeholder: UIImage(named: "UsersIcon"))
            }
            userCell.UserImageView.layer.masksToBounds = false
            userCell.UserImageView.layer.cornerRadius = userCell.UserImageView.frame.height/2
            userCell.UserImageView.clipsToBounds = true
            return userCell
        } else  {
            let repoCell = bookmarksTableView.dequeueReusableCell(withIdentifier: K.RepositoriesTableViewCellID, for: indexPath) as! RepositoriesTableViewCell
            repoCell.repoNameLabel.text = reposArray[indexPath.row].repoName
            repoCell.repoDescriptionLabel.text = reposArray[indexPath.row].repoDescription
            repoCell.programmingLangLabel.text = reposArray[indexPath.row].repoLanguage
            repoCell.starredNumberLabel.text = "\(reposArray[indexPath.row].starredNum)"
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
                let userItem = usersArray[indexPath.row]
                CoreDataManger.shared.delete(entityName: User.self, delete: userItem)
                CoreDataManger.shared.fetch(entityName: User.self) { (item) in
                    self.usersArray = item
                    DispatchQueue.main.async {
                        self.bookmarksTableView.reloadData()
                    }
                }
            } else {
                let item = reposArray[indexPath.row]
                CoreDataManger.shared.delete(entityName: Repo.self, delete: item)
                CoreDataManger.shared.fetch(entityName: Repo.self) { (item) in
                    self.reposArray = item
                    DispatchQueue.main.async {
                        self.bookmarksTableView.reloadData()
                    }
                }
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

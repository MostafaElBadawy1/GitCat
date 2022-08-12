//
//  UsersListViewController+TableView-Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//

import Foundation
import UIKit
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersListTableView.dequeueReusableCell(withIdentifier: K.UserListCellID, for: indexPath) as! UsersListTableViewCell
        cell.userNameLabel.text = filteredArray[indexPath.row].login
        cell.UserImageView.kf.setImage(with: URL(string: filteredArray[indexPath.row].avatar_url!),placeholder: UIImage(named: "UsersIcon"))
        //        cell.UserImageView.layer.borderWidth = 1
        cell.UserImageView.layer.masksToBounds = false
        //        cell.UserImageView.layer.borderColor = UIColor.black.cgColor
        cell.UserImageView.layer.cornerRadius = cell.UserImageView.frame.height/2
        cell.UserImageView.clipsToBounds = true
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usersListTableView.deselectRow(at: indexPath, animated: true)
        let userDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.UserDetailsViewControllerID) as! UserDetailsViewController
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        var cell = usersListTableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UsersListTableViewCell
//        cell.userNameLabel.text = filteredArray[indexPath.row].login
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "UserListCell") as! UsersListTableViewCell
//        }
//    }
//    func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
//        <#code#>
//    }
}

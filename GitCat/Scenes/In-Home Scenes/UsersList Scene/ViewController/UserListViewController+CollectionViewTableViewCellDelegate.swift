//
//  UserListViewController+CollectionViewTableViewCellDelegate.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 18/09/2022.
//
import UIKit
extension UsersListViewController: CollectionViewTableViewCellDelegate {
    func tappedCell(cell: CollectionViewTableViewCell, index: Int) {
        let userDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.userDetailsViewControllerID) as! UserDetailsViewController
        userDetailsVC.passeedDataFromUserListVC = visitedUserArray[index].userName
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}

//
//  UsersListViewController+TableView-Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//
import UIKit
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if usersArray.count == 0 {
            loadingIndicator.startAnimating()
        }
        return usersArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersListTableView.dequeueReusableCell(withIdentifier: K.UserListCellID, for: indexPath) as! UsersListTableViewCell
        cell.userNameLabel.text = usersArray[indexPath.row].login
        cell.UserImageView.kf.setImage(with: URL(string: usersArray[indexPath.row].avatar_url),placeholder: UIImage(named: "UsersIcon"))
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

//    func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) {
//        <#code#>
//    }
}
//extension UsersListViewController: UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let position = scrollView.contentOffset.y
//        if position > (usersListTableView.contentSize.height-100-scrollView.frame.size.height) {
//            //fetch more Users ()
////            id = id + 1
////            print(id)
////           fetchMoreUsers(id: id)
////            print("pagination")
//        }
//    }
//}
//extension UsersListViewController {
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == usersArray.count-1 {
//            pageNum = pageNum + 1
////            fetchMoreUsers(searchKeyword: "m", page: pageNum)
////            print("pagination")
//        }
//        //self.usersListTableView.tableFooterView = createSpinnerFooter()
//    }
//
//}
extension UsersListViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        let indices = indexPaths.map { "\($0.row)"}.joined(separator: ".")
//        print("prefetching \(indices)")
        for indexPath in indexPaths {
            if indexPath.row == preFetchIndex {
                preFetchIndex = preFetchIndex + 30
                pageNum = pageNum + 1
                fetchMoreUsers(searchKeyword: "m", page: pageNum)
            }
        }
    }
}

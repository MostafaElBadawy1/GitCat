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
        cell.UserImageView.kf.setImage(with: URL(string: usersArray[indexPath.row].avatar_url!),placeholder: UIImage(named: "UsersIcon"))
        cell.UserImageView.layer.masksToBounds = false
        cell.UserImageView.layer.cornerRadius = cell.UserImageView.frame.height/2
        cell.UserImageView.clipsToBounds = true
        //let image = UIImage(kf.setImage(with: URL(string: usersArray[indexPath.row].avatar_url))
        //let url = URL(string: usersArray[indexPath.row].html_url)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        usersListTableView.deselectRow(at: indexPath, animated: true)
        let passedDataToUserDetailsVC = usersArray[indexPath.row].login
        let userDetailsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.UserDetailsViewControllerID) as! UserDetailsViewController
        userDetailsVC.passeedDataFromUserListVC = passedDataToUserDetailsVC
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
}
extension UsersListViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        let indices = indexPaths.map { "\($0.row)"}.joined(separator: ".")
//        print("prefetching \(indices)")
        for indexPath in indexPaths {
            if indexPath.row == preFetchIndex {
                preFetchIndex = preFetchIndex + 30
                pageNum = pageNum + 1
                self.usersListTableView.tableFooterView = createSpinnerFooter()
                //fetchMoreUsers(searchKeyword: "m", page: pageNum)
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if filteredText.isEmpty {
                    fetchMoreUsers(searchKeyword: "m", page: pageNum)
                } else {
                fetchMoreUsers(searchKeyword: filteredText, page: pageNum)
                }
            }
        }
    }
}
extension UsersListViewController{
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let openWithSafariAction = UIAction(title: "Open With Safari", image: UIImage(systemName: "safari")) { _ in
                if let userURL = URL(string:"\(String(describing: self.usersArray[indexPath.row].html_url))" ){
                    UIApplication.shared.open(userURL)
                }
            }
            let bookmarkAction = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark")) { _ in
                print("Bookmarked!")
            }
            let saveImageeAction = UIAction(title: "Save Image", image: UIImage(systemName: "photo")) { _ in
                print("Save Image!")
                //UIImageWriteToSavedPhotosAlbum(<#T##image: UIImage##UIImage#>, <#T##completionTarget: Any?##Any?#>, <#T##completionSelector: Selector?##Selector?#>, <#T##contextInfo: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
            }
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), attributes: .destructive) { _ in
                print("Share!")
                self.presentShareSheet()
            }
            let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: [openWithSafariAction, bookmarkAction,saveImageeAction, shareAction])
            
            return menu
        }
        return config
    }
//    func tableView(_ tableView: UITableView, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
//        let
//    }
    private func presentShareSheet() {
        guard let image = UIImage(systemName: "bell"), let url = URL(string: "www.google.com") else {
            return
        }
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    
}
    
    
    
    
    
    
    
    
    
    
//    func tableView(_ tableView: UITableView, willDisplayContextMenu configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionAnimating?) -> <#Return Type#> {
//        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
//            return UIMenu(title: "",
//                          image: nil,
//                          identifier: nil,
//                          options: UIMenu.Options.displayInline,
//                          children: [])
//        }
//        return config
//    }

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

//// MARK: - UIContextMenuInteractionDelegate
//extension UsersListViewController: UIContextMenuInteractionDelegate {
//  func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
//    return UIContextMenuConfiguration(
//      identifier: nil,
//      previewProvider: nil,
//      actionProvider: { _ in
//        let children: [UIMenuElement] = []
//        return UIMenu(title: "", children: children)
//    })
//  }
//}


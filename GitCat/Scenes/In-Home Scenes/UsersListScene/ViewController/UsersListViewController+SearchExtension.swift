//
//  UsersListViewController+Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//

import UIKit
extension UsersListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
        return
    }
    print(text)
}
}
//MARK: - SearchBar
//extension UsersListViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchText == "" {
//           // filteredArray = usersArray
//            self.usersListTableView.reloadData()
//        } else {
//            filteredArray = usersArray.filter({ user in
//                return user.login!.contains(searchText.lowercased())
//            })
//            self.usersListTableView.reloadData()
//        }
//    }
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        usersSearchBar.endEditing(true)
//    }
//    func searchBarSearchButtonClicked(searchBar: UISearchBar)
//    {
////        searchActive = false;
//        self.usersSearchBar.endEditing(true)
//    }
//}

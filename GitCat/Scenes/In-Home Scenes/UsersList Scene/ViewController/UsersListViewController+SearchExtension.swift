//
//  UsersListViewController+Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//
import UIKit
extension UsersListViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        setup()
        searchHistoryVC.view.isHidden = false
        usersListTableView.isHidden = true
        loadingIndicator.stopAnimating()
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchHistoryVCConfig()
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchHistoryVCConfig()
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
        fetchUsers(searchKeyword: filteredText)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchHistoryVCConfig()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        print(filteredText)
        fetchUsers(searchKeyword: filteredText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchHistoryVCConfig()
    }
}







//This sample includes the optional—but recommended—UIStateRestoring protocol. You adopt this protocol from the view controller class to save the search bar’s active state, first responder status, and search bar text and restore them when the app is relaunched.


//extension UsersListViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
////        guard let text = searchController.searchBar.text else {
////        return
////    }
//          //  fetchUser(searchKeyword: text, page: 1)
//}
//}


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


//
//  UsersListViewController+Ext.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//

import UIKit

//extension UsersListViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
////        guard let text = searchController.searchBar.text else {
////        return
////    }
//          //  fetchUser(searchKeyword: text, page: 1)
//}
//}
extension UsersListViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
        fetchUsers(searchKeyword: filteredText, page: 1)

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        fetchUsers(searchKeyword: filteredText, page: 1)
    }
    
    //    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    //        <#code#>
    //    }
        
    //    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    //        guard let text = searchController.searchBar.text else {
    //        return
    //    }
    //        fetchUsers(searchKeyword: text, page: 1)
    //    }
    
  //  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      //  guard let text = self.searchController.searchBar.text else {
         // return
     // }
        //timer.in
       //let  timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in

            //self.fetchUser(searchKeyword: text, page: 1)
    
//            guard let text = self.searchController.searchBar.text else {
//        return
//    }
//            self.fetchUser(searchKeyword: text, page: 1)
    
//}
}






//This sample includes the optional—but recommended—UIStateRestoring protocol. You adopt this protocol from the view controller class to save the search bar’s active state, first responder status, and search bar text and restore them when the app is relaunched.




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


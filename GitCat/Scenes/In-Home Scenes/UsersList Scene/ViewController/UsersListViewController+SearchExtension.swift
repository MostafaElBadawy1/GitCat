//
//  UsersListViewController+SearchExtension.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//
import UIKit
extension UsersListViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
       // setup()
        //searchHistoryVC.view.isHidden = false
       // usersListTableView.isHidden = true
        //loadingIndicator.stopAnimating()
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
       // searchHistoryVCConfig()
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       // searchHistoryVCConfig()
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
        fetchUsers(for: filteredText)
//        let searchWord = SearchedWord(context: self.context)
//        searchWord.word = filteredText
//            do {
//                try self.context.save()
//            } catch {
//                presentAlert(title: "Error While Saving Search Word", message: "")
//            }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // searchHistoryVCConfig()
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        //print(filteredText)
        fetchUsers(for: filteredText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchUsers(for: "mo")
        noUserslabel.isHidden = true
       // searchHistoryVCConfig()
    }
}


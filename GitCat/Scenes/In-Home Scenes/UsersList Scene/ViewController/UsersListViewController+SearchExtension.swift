//
//  UsersListViewController+SearchExtension.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 22/07/2022.
//
import UIKit
extension UsersListViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        //searchHistoryVC.view.isHidden = false
        usersListTableView.isHidden = true
        searchHistoryTableView.isHidden = false
        if visitedUserArray.isEmpty && searchedWordsArray.isEmpty {
            emptySearchVClabelsConfig()
            searchHistoryTableView.isHidden = true
        } else {
            firstlabel.isHidden = true
            secondlabel.isHidden = true
        }
        loadingIndicator.stopAnimating()
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        usersListTableView.isHidden = false
        searchHistoryTableView.isHidden = false
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        usersListTableView.isHidden = false
        searchHistoryTableView.isHidden = true
        guard let text = searchController.searchBar.text else { return }
        fetchUsers(for: text)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        usersListTableView.isHidden = false
        searchHistoryTableView.isHidden = true
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber || $0.isPunctuation }
        if filteredText.isEmpty {
            usersListTableView.isHidden = true
            searchHistoryTableView.isHidden = false
        } else {
            fetchUsers(for: filteredText)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchUsers(for: "mo")
        noUserslabel.isHidden = true
        usersListTableView.isHidden = false
        searchHistoryTableView.reloadData()
        searchHistoryTableView.isHidden = true
        firstlabel.isHidden = true
        secondlabel.isHidden = true
//        guard let text = searchController.searchBar.text else { return }
//        let searchWord = SearchedWord(context: self.context)
//        searchWord.word = text
//        if text.isEmpty {
//            return
//        } else {
//            do {
//                try self.context.save()
//            } catch {
//                context.reset()
//            }
//        }
    }
}

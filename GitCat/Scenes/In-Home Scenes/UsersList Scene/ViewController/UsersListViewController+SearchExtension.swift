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
        let searchWord = SearchedWord(context: self.context)
        searchWord.word = filteredText
            do {
                try self.context.save()
            } catch {
                let alert : UIAlertController = UIAlertController(title:"Error While Saving Search Word" , message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
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


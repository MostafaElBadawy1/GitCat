//
//  ExploreViewController+SearchExtension.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 15/09/2022.
//
import UIKit
extension ExploreViewController: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
        fetchSearchedExploreRepos(searchWord: filteredText)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        fetchSearchedExploreRepos(searchWord: filteredText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        fetchSearchedExploreRepos(searchWord: "a")
        noReposLabel.isHidden = true
    }
}


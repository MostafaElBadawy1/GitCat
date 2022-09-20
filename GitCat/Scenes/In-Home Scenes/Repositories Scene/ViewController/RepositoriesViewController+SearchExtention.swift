//
//  RepositoriesViewController+SearchExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//
import UIKit
extension RepositoriesViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
       searchRepos(for: filteredText)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        searchRepos(for: filteredText)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchRepos(for: "r")
    }
}

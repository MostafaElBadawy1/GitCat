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
        fetchSearchedRepos(searchKeyword: filteredText, pageNum: 1)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
    @objc func reload() {
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber }
        fetchSearchedRepos(searchKeyword: filteredText, pageNum: 1)
    }
}

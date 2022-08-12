//
//  RepositoriesViewController+SearchExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//

import UIKit

extension RepositoriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        print(text)
    }
}

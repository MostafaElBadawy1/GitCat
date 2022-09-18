//
//  HomeViewController+SearchExt.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/08/2022.
//

import Foundation
import UIKit

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        print(text)
    }
}
extension HomeViewController: UISearchControllerDelegate {
    
}
extension HomeViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
       // setup()
        return true
    }
}

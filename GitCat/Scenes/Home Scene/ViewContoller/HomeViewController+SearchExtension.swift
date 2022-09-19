//
//  HomeViewController+SearchExt.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/08/2022.
//
import UIKit
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return}
        query = text
    }
}
//extension HomeViewController: UISearchControllerDelegate {
// 
//}
extension HomeViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
       // navigatingSearchTableViewConfig()
        searchHistoryTableViewConfig()
        homeTableView.isHidden = true
        searchHistoryTableView.isHidden = false
        navigatingSearchTableView.isHidden = true
        if visitedUserArray.isEmpty && searchedWordsArray.isEmpty {
            emptySearchVClabelsConfig()
        }
        //loadingIndicator.stopAnimating()
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        homeTableView.isHidden = false
        searchHistoryTableView.isHidden = true
        navigatingSearchTableView.isHidden = true
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        homeTableView.isHidden = true
        searchHistoryTableView.isHidden = true
        navigatingSearchTableView.isHidden = false
        guard let text = searchController.searchBar.text else { return }
        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
        let searchWord = SearchedWord(context: self.context)
        searchWord.word = filteredText
        if filteredText.isEmpty {
            return
        } else {
            searchBar.isSearchResultsButtonSelected = false
            do {
                try self.context.save()
            } catch {
                presentAlert(title: "Error While Saving Search Word", message: "")
            }
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchController.searchBar.text else { return }
        navigatingSearchTableViewConfig()
        homeTableView.isHidden = true
        searchHistoryTableView.isHidden = true
        navigatingSearchTableView.isHidden = false
        if text.isEmpty {
            searchHistoryTableView.isHidden = false
            navigatingSearchTableView.isHidden = true
        }
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(reload), object: nil)
//        self.perform(#selector(reload), with: nil, afterDelay: 1)
    }
//    @objc func reload() {
//        guard let text = searchController.searchBar.text else { return }
//        let filteredText = text.filter { $0.isLetter || $0.isNumber || $0.isPunctuation }
//        if filteredText.isEmpty {
//            homeTableView.isHidden = true
//            searchHistoryTableView.isHidden = false
//        } else {
//            fetchUsers(for: filteredText)
//        }
//    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        homeTableView.isHidden = false
        searchHistoryTableView.isHidden = true
        navigatingSearchTableView.isHidden = true
        guard let text = searchController.searchBar.text else { return }
        //        let filteredText = text.filter { $0.isLetter || $0.isNumber  }
        let searchWord = SearchedWord(context: self.context)
        searchWord.word = text
        if text.isEmpty {
            return
        } else {
            do {
                try self.context.save()
            } catch {
                presentAlert(title: "Error While Saving Search Word", message: "")
            }
        }
    }
}

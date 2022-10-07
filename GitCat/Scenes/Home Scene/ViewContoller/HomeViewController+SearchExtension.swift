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
        if  searchedWordsArray.isEmpty {
            emptySearchVClabelsConfig(firstLabel: findYourStuffLabel, secondLabel: searchGithubLabel)
            searchHistoryTableView.isHidden = true
        } else {
            findYourStuffLabel.isHidden = true
            searchGithubLabel.isHidden = true
        }
        //loadingIndicator.stopAnimating()
        return true
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        homeTableView.isHidden = false
        searchHistoryTableView.isHidden = true
        navigatingSearchTableView.isHidden = true
        findYourStuffLabel.isHidden = true
        searchGithubLabel.isHidden = true
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        homeTableView.isHidden = true
        searchHistoryTableView.isHidden = true
        navigatingSearchTableView.isHidden = false
//        guard let text = searchController.searchBar.text else { return }
//        let searchWord = SearchedWord(context: self.context)
//        searchWord.word = text
//        if text.isEmpty {
//            return
//        } else {
//            searchBar.isSearchResultsButtonSelected = false
//            do {
//                try self.context.save()
//            } catch {
//                context.reset()
//                //presentAlert(title: "Error While Saving Search Word", message: "")
//            }
//        }
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
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        homeTableView.isHidden = false
        searchHistoryTableView.isHidden = true
        searchHistoryTableView.reloadData()
        navigatingSearchTableView.isHidden = true
        findYourStuffLabel.isHidden = true
        searchGithubLabel.isHidden = true
        fetchSearchedWords()
//        guard let text = searchController.searchBar.text else { return }
//        let searchWord = SearchedWord(context: self.context)
//        searchWord.word = text
//        if text.isEmpty  {
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

//
//  BookmarksViewController+SearchExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//
import UIKit
//extension BookmarksViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let text = searchController.searchBar.text else {return}
//        print(text)
//        if text == "" {
//            filterdUserArray = usersArray
//            filterdReposArray = reposArray
//            self.bookmarksTableView.reloadData()
//        } else {
//            filterdUserArray = usersArray.filter({ mod in
//                return mod.userName!.contains(text)
//            })
//            filterdReposArray = reposArray.filter({ mod in
//                return mod.repoName!.contains(text)
//            })
//            self.bookmarksTableView.reloadData()
//        }
//
//    }
//}
extension BookmarksViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        if searchText == "" {
            filterdUserArray = usersArray
            filterdReposArray = reposArray
            self.bookmarksTableView.reloadData()
        } else {
            filterdUserArray = usersArray.filter({ mod in
                return mod.userName!.contains(searchText.lowercased())
            })
            filterdReposArray = reposArray.filter({ mod in
                return mod.repoName!.contains(searchText)
            })
            self.bookmarksTableView.reloadData()
        }

    }
}

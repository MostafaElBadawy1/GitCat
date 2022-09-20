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
            filterdUserArray = usersArray.filter({ model in
                return model.userName!.contains(searchText.lowercased())
            })
            filterdReposArray = reposArray.filter({ model in
                return model.repoFullName!.contains(searchText.lowercased()) || model.repoName!.contains(searchText.lowercased())
            })
            self.bookmarksTableView.reloadData()
        }

    }
}

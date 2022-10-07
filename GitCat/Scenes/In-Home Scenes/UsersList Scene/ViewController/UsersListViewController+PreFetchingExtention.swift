//
//  UsersListViewController+PreFetchingExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 18/09/2022.
//
import UIKit
extension UsersListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == usersViewModel.preFetchIndex {
                self.usersListTableView.tableFooterView = createSpinnerFooter(loadingIndicator: loadingIndicator)
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if filteredText.isEmpty {
                    fetchMoreUsers(for : "mo", pageNum: usersViewModel.pageNumber)
                } else {
                    fetchMoreUsers(for: filteredText, pageNum: usersViewModel.pageNumber)
                }
                usersViewModel.preFetchIndex = usersViewModel.preFetchIndex + 30
                usersViewModel.pageNumber = usersViewModel.pageNumber + 1
            }
        }
    }
}

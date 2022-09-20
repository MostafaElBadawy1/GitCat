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
            if indexPath.row == preFetchIndex {
                self.usersListTableView.tableFooterView = createSpinnerFooter()
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if filteredText.isEmpty {
                    fetchMoreUsers(for : "mo", pageNum: pageNumber)
                } else {
                    fetchMoreUsers(for: filteredText, pageNum: pageNumber)
                }
                preFetchIndex = preFetchIndex + 30
                pageNumber = pageNumber + 1
            }
        }
    }
}

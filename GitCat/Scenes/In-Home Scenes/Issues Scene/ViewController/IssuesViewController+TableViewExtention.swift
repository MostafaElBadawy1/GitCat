//
//  IssuesViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
extension IssuesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if issuesArray.isEmpty {
            loadingIndicator.startAnimating()
        }
        return issuesArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        issuesTableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = issuesTableView.dequeueReusableCell(withIdentifier: K.CommitsTableViewCellID, for: indexPath) as! CommitsTableViewCell
        cell.userNameLabel.text = issuesArray[indexPath.row].title
        cell.commitMessageLabel.text = issuesArray[indexPath.row].state
        return cell
    }
}
extension IssuesViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == preFetchIndex {
                preFetchIndex = preFetchIndex + 30
                pageNum = pageNum + 1
                self.issuesTableView.tableFooterView = createSpinnerFooter()
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if filteredText.isEmpty {
                    fetchMoreIssues(searchWord: "p", pageNum: pageNum)
                } else {
                    fetchMoreIssues(searchWord: text, pageNum: pageNum)
                }
            }
        }
    }
}

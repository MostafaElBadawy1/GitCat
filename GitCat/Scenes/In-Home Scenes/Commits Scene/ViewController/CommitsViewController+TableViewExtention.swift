//
//  CommitsViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//
import UIKit
extension CommitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if commitsArray.isEmpty {
            loadingIndicator.startAnimating()
        }
        return commitsArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commitsTableView.deselectRow(at: indexPath, animated: true)
        if let commitsURL = URL(string:"\(String(describing: commitsArray[indexPath.row].html_url))" ){
            UIApplication.shared.open(commitsURL)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commitsTableView.dequeueReusableCell(withIdentifier: K.CommitsTableViewCellID, for: indexPath) as! CommitsTableViewCell
        cell.userNameLabel.text = commitsArray[indexPath.row].commit.committer?.name
        cell.commitMessageLabel.text = commitsArray[indexPath.row].commit.message
        return cell
    }
}
extension CommitsViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
            for indexPath in indexPaths {
                if indexPath.row == preFetchIndex {
                    preFetchIndex = preFetchIndex + 30
                    pageNum = pageNum + 1
                    self.commitsTableView.tableFooterView = createSpinnerFooter()
                    fetchMoreCommits(ownerName: repoOwner!, repoName: repoName!, pageNum: pageNum)
                }
            }
        }
    }
}

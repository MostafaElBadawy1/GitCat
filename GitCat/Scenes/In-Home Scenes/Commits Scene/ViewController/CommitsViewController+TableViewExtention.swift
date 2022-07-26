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
        return commitsArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commitsTableView.deselectRow(at: indexPath, animated: true)
        if let commitsURL = URL(string:"\(String(describing: commitsArray[indexPath.row].html_url))" ){
            UIApplication.shared.open(commitsURL)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commitsTableView.dequeueReusableCell(withIdentifier: K.commitsTableViewCellID, for: indexPath) as! CommitsTableViewCell
        cell.userNameLabel.text = commitsArray[indexPath.row].commit.committer?.name
        cell.commitMessageLabel.text = commitsArray[indexPath.row].commit.message
        return cell
    }
}
extension CommitsViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == commitsViewModel.preFetchIndex {
                commitsViewModel.preFetchIndex = commitsViewModel.preFetchIndex + 30
                commitsViewModel.pageNum = commitsViewModel.pageNum + 1
                self.commitsTableView.tableFooterView = createSpinnerFooter(loadingIndicator: loadingIndicator)
                if let owner = repoOwner, let repo = repoName {
                    fetchMoreCommits(ownerName: owner, repoName: repo, pageNum: commitsViewModel.pageNum)
                }
            }
        }
    }
}

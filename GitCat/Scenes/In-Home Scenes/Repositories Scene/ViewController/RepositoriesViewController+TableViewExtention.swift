//
//  RepositoriesViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchedReposArray.isEmpty && reposArray.isEmpty{
            loadingIndicator.startAnimating()
        }
        if isWithSearchController == true {
            return searchedReposArray.count
        } else {
            return reposArray.count
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repositoriesTableView.deselectRow(at: indexPath, animated: true)
        let commitsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.CommitsViewControllerID) as! CommitsViewController
        if isWithSearchController == true {
            commitsVC.repoName = searchedReposArray[indexPath.row].name
            commitsVC.repoOwner = searchedReposArray[indexPath.row].owner.login
        } else {
            commitsVC.repoName = reposArray[indexPath.row].name
            commitsVC.repoOwner = reposArray[indexPath.row].owner.login
        }
        self.navigationController?.pushViewController(commitsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: K.RepositoriesTableViewCellID, for: indexPath) as! RepositoriesTableViewCell
        if isWithSearchController == true {
            cell.repoNameLabel.text = searchedReposArray[indexPath.row].full_name!
            cell.repoDescriptionLabel.text = searchedReposArray[indexPath.row].description
            cell.starredNumberLabel.text = "\(searchedReposArray[indexPath.row].stargazers_count!)"
            cell.programmingLangLabel.text = searchedReposArray[indexPath.row].language
        } else {
            cell.repoNameLabel.text = reposArray[indexPath.row].name
            cell.repoDescriptionLabel.text = reposArray[indexPath.row].description
            cell.starredNumberLabel.text = "\(reposArray[indexPath.row].stargazers_count)"
            cell.programmingLangLabel.text = reposArray[indexPath.row].language
        }
        
        return cell
    }
}
extension RepositoriesViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == preFetchIndex {
                preFetchIndex = preFetchIndex + 30
                pageNum = pageNum + 1
                self.repositoriesTableView.tableFooterView = createSpinnerFooter()
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if isWithSearchController == true {
                    if filteredText.isEmpty {
                        fetchMoreSearchedRepos(userName:"m", pageNum: pageNum)
                    } else {
                        fetchMoreSearchedRepos(userName:filteredText, pageNum: pageNum)
                    }
                } else {
                    fetchMoreRepos(userName: "\(passedNameFromUserDetailsVC!)", pageNum: pageNum)
                }
            }
        }
    }
}

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
            return reposArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repositoriesTableView.deselectRow(at: indexPath, animated: true)
        let commitsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.commitsViewControllerID) as! CommitsViewController
            commitsVC.repoName = reposArray[indexPath.row].name
            commitsVC.repoOwner = reposArray[indexPath.row].owner?.login
        self.navigationController?.pushViewController(commitsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: K.repositoriesTableViewCellID, for: indexPath) as! RepositoriesTableViewCell
        cell.delegate = self
        cell.index = indexPath
        cell.languageIndicator.isHidden = true
            cell.repoNameLabel.text = reposArray[indexPath.row].name
            cell.repoDescriptionLabel.text = reposArray[indexPath.row].description
            cell.starredNumberLabel.text = "\(reposArray[indexPath.row].stargazers_count!)"
            cell.programmingLangLabel.text = reposArray[indexPath.row].language
            cell.repoImageView.kf.setImage(with: URL(string: (reposArray[indexPath.row].owner?.avatar_url!)!),placeholder: UIImage(named: "repoIcon"))
        cell.repoImageView.layer.masksToBounds = false
        cell.repoImageView.layer.cornerRadius = cell.repoImageView.frame.height/2
        cell.repoImageView.clipsToBounds = true
        return cell
    }
}
extension RepositoriesViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == repositoriesForUserViewModel.preFetchIndex {
                self.repositoriesTableView.tableFooterView = createSpinnerFooter(loadingIndicator: loadingIndicator)
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if isWithSearchController == true {
                    if filteredText.isEmpty {
                        searchMoreRepos(for: "r", pageNum: repositoriesForUserViewModel.pageNum)
                    } else {
                        searchMoreRepos(for: filteredText, pageNum: repositoriesForUserViewModel.pageNum)
                    }
                } else {
                    if let userName = passedNameFromUserDetailsVC  {
                        fetchMoreUserRepositories(repoOwner: userName, pageNum: repositoriesForUserViewModel.pageNum)
                    }
                }
                repositoriesForUserViewModel.pageNum = repositoriesForUserViewModel.pageNum + 1
                repositoriesForUserViewModel.preFetchIndex = repositoriesForUserViewModel.preFetchIndex + 30
            }
        }
    }
}




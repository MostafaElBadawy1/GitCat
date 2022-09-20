//
//  ExploreViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        160
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exploreReposArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        exploreTableView.deselectRow(at: indexPath, animated: true)
        let commitsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.CommitsViewControllerID) as! CommitsViewController
        commitsVC.repoName = exploreReposArray[indexPath.row].name
        commitsVC.repoOwner = exploreReposArray[indexPath.row].owner?.login
        self.navigationController?.pushViewController(commitsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = exploreTableView.dequeueReusableCell(withIdentifier: K.ExploreTableViewCellID, for: indexPath) as! ExploreTableViewCell
        cell.delegate = self
        cell.index = indexPath
        cell.repoNameLabel.text = exploreReposArray[indexPath.row].full_name!
        cell.descreptionLabel.text = exploreReposArray[indexPath.row].description
        cell.starredNumLabel.text = "\(exploreReposArray[indexPath.row].stargazers_count!)"
        cell.languageLabel.text = exploreReposArray[indexPath.row].language
        cell.repoImageView.kf.setImage(with: URL(string: (exploreReposArray[indexPath.row].owner?.avatar_url!)!),placeholder: UIImage(named: "repoIcon"))
        cell.repoImageView.layer.masksToBounds = false
        cell.repoImageView.layer.cornerRadius = cell.repoImageView.frame.height/2
        cell.repoImageView.clipsToBounds = true
        return cell
    }
}
extension ExploreViewController: UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.row == preFetchIndex {
                self.exploreTableView.tableFooterView = createSpinnerFooter()
                guard let text = searchController.searchBar.text else { return }
                let filteredText = text.filter { $0.isLetter || $0.isNumber  }
                if filteredText.isEmpty {
                    fetchMoreSearchedExploreRepos(searchWord: "a", pageNum: pageNumber)
                } else {
                    fetchMoreSearchedExploreRepos(searchWord: filteredText, pageNum: pageNumber)
                }
                pageNumber = pageNumber + 1
                preFetchIndex = preFetchIndex + 30
            }
        }
    }
}


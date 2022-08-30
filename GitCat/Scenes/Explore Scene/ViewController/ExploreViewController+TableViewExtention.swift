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
                preFetchIndex = preFetchIndex + 30
                pageNum = pageNum + 1
                self.exploreTableView.tableFooterView = createSpinnerFooter()
                fetchMoreSearchedRepos(pageNum: pageNum)
            }
        }
    }
}
extension ExploreViewController: ExploreCellDelegate {
    func addStarredCell(cell: ExploreTableViewCell, index: Int) {
        let repoModel = Repo(context: self.context)
        repoModel.repoName = exploreReposArray[index].full_name
        repoModel.repoDescription = exploreReposArray[index].description
        repoModel.repoLanguage = exploreReposArray[index].language
        repoModel.starredNum = Int64(exploreReposArray[index].stargazers_count!)
        repoModel.repoImageUrl = URL(string: (exploreReposArray[index].owner?.avatar_url)!)
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
}
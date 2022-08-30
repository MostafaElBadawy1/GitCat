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
        if isStarredReposVC == true {
            return reposArray.count
        } else {
            if isWithSearchController == true {
                return searchedReposArray.count
            } else {
                return reposArray.count
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repositoriesTableView.deselectRow(at: indexPath, animated: true)
        let commitsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.CommitsViewControllerID) as! CommitsViewController
        if isStarredReposVC == true {
            commitsVC.repoName = reposArray[indexPath.row].name
            commitsVC.repoOwner = reposArray[indexPath.row].owner?.login
        } else {
            if isWithSearchController == true {
                commitsVC.repoName = searchedReposArray[indexPath.row].name
                commitsVC.repoOwner = searchedReposArray[indexPath.row].owner?.login
            } else {
                commitsVC.repoName = reposArray[indexPath.row].name
                commitsVC.repoOwner = reposArray[indexPath.row].owner?.login
            }
        }
        self.navigationController?.pushViewController(commitsVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = repositoriesTableView.dequeueReusableCell(withIdentifier: K.RepositoriesTableViewCellID, for: indexPath) as! RepositoriesTableViewCell
        cell.delegate = self
        cell.index = indexPath
        //        if cell.programmingLangLabel.text == "Swift" {
        //             cell.languageIndicator.tintColor = .red
        //        } else if cell.programmingLangLabel.text == "Shell" {
        //            cell.languageIndicator.tintColor = .systemMint
        //        } else if cell.programmingLangLabel.text == "Java" {
        //            cell.languageIndicator.tintColor = .systemBrown
        //        } else if cell.programmingLangLabel.text == "JavaScript" {
        //            cell.languageIndicator.tintColor = .systemYellow
        //        } else if cell.programmingLangLabel.text == "C" {
        //            cell.languageIndicator.tintColor = .systemBrown
        //        } else if cell.programmingLangLabel.text == "TypeScript"  {
        //            cell.languageIndicator.tintColor = .systemBlue
        //        } else if cell.programmingLangLabel.text == "Python"  {
        //            cell.languageIndicator.tintColor = .systemBlue
        //        } else if cell.programmingLangLabel.text == "C++"  {
        //            cell.languageIndicator.tintColor = .systemRed
        //        } else if cell.programmingLangLabel.text == "HTML"  {
        //            cell.languageIndicator.tintColor = .systemRed
        //        } else if cell.programmingLangLabel.text == "Kotlin"  {
        //            cell.languageIndicator.tintColor = .systemPurple
        //        } else if cell.programmingLangLabel.text == "PHP"  {
        //            cell.languageIndicator.tintColor = .systemBlue
        //        }
        //        if ((cell.programmingLangLabel.text?.isEmpty) != nil) {
        //            cell.languageIndicator.isHidden = true
        //        }
        cell.languageIndicator.isHidden = true
        if isStarredReposVC == true {
            cell.repoNameLabel.text = reposArray[indexPath.row].name
            cell.repoDescriptionLabel.text = reposArray[indexPath.row].description
            cell.starredNumberLabel.text = "\(reposArray[indexPath.row].stargazers_count!)"
            cell.programmingLangLabel.text = reposArray[indexPath.row].language
            cell.repoImageView.kf.setImage(with: URL(string: (reposArray[indexPath.row].owner?.avatar_url!)!),placeholder: UIImage(named: "repoIcon"))
        } else {
            if isWithSearchController == true {
                cell.repoNameLabel.text = searchedReposArray[indexPath.row].full_name!
                cell.repoDescriptionLabel.text = searchedReposArray[indexPath.row].description
                cell.starredNumberLabel.text = "\(searchedReposArray[indexPath.row].stargazers_count!)"
                cell.programmingLangLabel.text = searchedReposArray[indexPath.row].language
                cell.repoImageView.kf.setImage(with: URL(string: (searchedReposArray[indexPath.row].owner?.avatar_url!)!),placeholder: UIImage(named: "repoIcon"))
            } else {
                cell.repoNameLabel.text = reposArray[indexPath.row].name
                cell.repoDescriptionLabel.text = reposArray[indexPath.row].description
                cell.starredNumberLabel.text = "\(reposArray[indexPath.row].stargazers_count!)"
                cell.programmingLangLabel.text = reposArray[indexPath.row].language
                cell.repoImageView.kf.setImage(with: URL(string: (reposArray[indexPath.row].owner?.avatar_url!)!),placeholder: UIImage(named: "repoIcon"))
            }
        }
        cell.repoImageView.layer.masksToBounds = false
        cell.repoImageView.layer.cornerRadius = cell.repoImageView.frame.height/2
        cell.repoImageView.clipsToBounds = true
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
                        fetchMoreSearchedRepos(searchKeyword:"m", pageNum: pageNum)
                    } else {
                        fetchMoreSearchedRepos(searchKeyword:filteredText, pageNum: pageNum)
                    }
                } else {
                    fetchMoreRepos(userName: "\(passedNameFromUserDetailsVC!)", pageNum: pageNum)
                }
            }
        }
    }
}
extension RepositoriesViewController: RepostableCellDelegate {
    func addTappedCell(cell: RepositoriesTableViewCell, index: Int) {
        let repoModel = Repo(context: self.context)
        if isStarredReposVC == true {
            repoModel.repoName = reposArray[index].full_name
            repoModel.repoDescription = reposArray[index].description
            repoModel.repoLanguage = reposArray[index].language
            repoModel.starredNum = Int64(reposArray[index].stargazers_count!)
            repoModel.repoImageUrl = URL(string: ((reposArray[index].owner?.avatar_url)!)!)
        } else {
            if isWithSearchController == true {
                repoModel.repoName = searchedReposArray[index].full_name
                repoModel.repoDescription = searchedReposArray[index].description
                repoModel.repoLanguage = searchedReposArray[index].language
                repoModel.starredNum = Int64(searchedReposArray[index].stargazers_count!)
                repoModel.repoImageUrl = URL(string: ((searchedReposArray[index].owner?.avatar_url)!))
            } else {
                repoModel.repoName = reposArray[index].full_name
                repoModel.repoDescription = reposArray[index].description
                repoModel.repoLanguage = reposArray[index].language
                repoModel.starredNum = Int64(reposArray[index].stargazers_count!)
                repoModel.repoImageUrl = URL(string: ((reposArray[index].owner?.avatar_url)!)!)
            }
        }
        do {
            try self.context.save()
        } catch {
            print(error)
        }
    }
}


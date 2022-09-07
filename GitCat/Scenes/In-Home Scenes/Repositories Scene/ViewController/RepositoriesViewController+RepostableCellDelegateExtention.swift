//
//  RepositoriesViewController+RepostableCellDelegateExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/09/2022.
//
import UIKit
extension RepositoriesViewController: RepostableCellDelegate {
    func addTappedCell(cell: RepositoriesTableViewCell, index: Int) {
        let repoModel = Repo(context: self.context)
        if isStarredReposVC == true || isWithSearchController == false {
            repoModel.repoName = reposArray[index].name
            repoModel.repoFullName = reposArray[index].full_name
            repoModel.repoDescription = reposArray[index].description
            repoModel.repoLanguage = reposArray[index].language
            repoModel.starredNum = Int64(reposArray[index].stargazers_count!)
            repoModel.repoImageUrl = URL(string: ((reposArray[index].owner?.avatar_url)!)!)
            repoModel.ownerName = reposArray[index].owner?.login
        } else if isWithSearchController == true {
            repoModel.repoName = searchedReposArray[index].name
            repoModel.repoFullName = searchedReposArray[index].full_name
            repoModel.repoDescription = searchedReposArray[index].description
            repoModel.repoLanguage = searchedReposArray[index].language
            repoModel.starredNum = Int64(searchedReposArray[index].stargazers_count!)
            repoModel.repoImageUrl = URL(string: ((searchedReposArray[index].owner?.avatar_url)!))
            repoModel.ownerName = searchedReposArray[index].owner?.login
        }
        do {
            try self.context.save()
        } catch {
            context.reset()
            let alert : UIAlertController = UIAlertController(title:"This Repository Is Already Bookmarked" , message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

//
//  ExploreViewController+ExploreCellDelegate.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 19/09/2022.
//
import UIKit
extension ExploreViewController: ExploreCellDelegate {
    func addStarredCell(cell: ExploreTableViewCell, index: Int) {
        let repoModel = Repo(context: self.context)
        repoModel.repoFullName = exploreReposArray[index].full_name
        repoModel.repoDescription = exploreReposArray[index].description
        repoModel.repoLanguage = exploreReposArray[index].language
        repoModel.starredNum = Int64(exploreReposArray[index].stargazers_count!)
        repoModel.repoImageUrl = URL(string: (exploreReposArray[index].owner?.avatar_url)!)
        do {
            try self.context.save()
            presentAlert(title: "Repository Added to Bookmarks" , message: "")
        } catch {
            context.reset()
            presentAlert(title: "This Repository Is Already Bookmarked" , message: "")
        }
    }
}

//
//  RepositoriesViewController+ContextMenuExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/09/2022.
//
import UIKit
extension RepositoriesViewController {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let openWithSafariAction = UIAction(title: "Open With Safari", image: UIImage(systemName: "safari")) { [self] _ in
                if isStarredReposVC == true || isWithSearchController == false {
                    UIApplication.shared.open(URL(string: (self.reposArray[indexPath.row].owner?.html_url!)!)!)
                }
            }
            let bookmarkAction = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark")) { _ in
                self.bookmarkRepo(cellIndexPath: indexPath)
            }
            let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                self.presentShareSheet(cellIndexPath: indexPath)
            }
            let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: [openWithSafariAction, bookmarkAction, shareAction])
            return menu
        }
        return config
    }
    private func presentShareSheet(cellIndexPath: IndexPath) {
        if isStarredReposVC == true || isWithSearchController == false {
            let url = URL(string: (reposArray[cellIndexPath.row].owner?.html_url!)!)
            let shareSheetVC = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
            present(shareSheetVC, animated: true)
        }
    }
    func bookmarkRepo(cellIndexPath: IndexPath) {
        let repoModel = Repo(context: self.context)
            repoModel.repoName = reposArray[cellIndexPath.row].name
            repoModel.repoFullName = reposArray[cellIndexPath.row].full_name
            repoModel.repoDescription = reposArray[cellIndexPath.row].description
            repoModel.repoLanguage = reposArray[cellIndexPath.row].language
            repoModel.starredNum = Int64(reposArray[cellIndexPath.row].stargazers_count!)
            repoModel.repoImageUrl = URL(string: ((reposArray[cellIndexPath.row].owner?.avatar_url)!)!)
            repoModel.ownerName = reposArray[cellIndexPath.row].owner?.login
        do {
            try self.context.save()
            presentAlert(title: "Repository Added to Bookmarks" , message: "")
        } catch {
            context.reset()
            presentAlert(title: "This Repository Is Already Bookmarked" , message: "")
        }
    }
}

//
//  UserListViewController+ContextMenu.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 07/09/2022.
//
import UIKit
extension UsersListViewController{
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        if tableView ==  usersListTableView {
            let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
                let openWithSafariAction = UIAction(title: "Open With Safari", image: UIImage(systemName: "safari")) { _ in
                    UIApplication.shared.open(URL(string: self.usersArray[indexPath.row].html_url!)!)
                }
                let bookmarkAction = UIAction(title: "Bookmark", image: UIImage(systemName: "bookmark")) { _ in
                    self.bookmarkUser(cellIndexPath: indexPath)
                }
                let saveImageeAction = UIAction(title: "Save Image", image: UIImage(systemName: "photo")) { _ in
                    self.downloadImage(cellIndexPath: indexPath)
                }
                let shareAction = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { _ in
                    self.presentShareSheet(cellIndexPath: indexPath)
                }
                let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: [openWithSafariAction, bookmarkAction,saveImageeAction, shareAction])
                return menu
            }
            return config
        } else {
           return nil
        }
        
    }
    func downloadImage(cellIndexPath: IndexPath) {
        let imagestring = usersArray[cellIndexPath.row].avatar_url

        if let url = URL(string: imagestring!),
               let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
               UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
           }
        presentAlert (title: "User's Photo Saved", message: "")
    }
    private func presentShareSheet(cellIndexPath: IndexPath) {
        let image = UIImageView()
      guard let url = URL(string: usersArray[cellIndexPath.row].html_url!) else {
            return
        }
        image.kf.setImage(with: URL(string: usersArray[cellIndexPath.row].avatar_url!),placeholder: UIImage(named: "UsersIcon"))
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    func bookmarkUser(cellIndexPath: IndexPath) {
        let oneUser = User(context: self.context)
        oneUser.userName = usersArray[cellIndexPath.row].login
        oneUser.userImageURL = URL(string:(usersArray[cellIndexPath.row].avatar_url)!)
        do {
            try self.context.save()
            presentAlert (title: "User Added to Bookmarks", message: "")
        } catch {
            context.reset()
            presentAlert (title: "This User Is Already Bookmarked", message: "")
        }
    }
}

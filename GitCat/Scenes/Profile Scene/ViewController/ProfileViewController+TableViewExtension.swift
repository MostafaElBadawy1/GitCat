//
//  ProfileViewController+TableViewExtension.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//

import UIKit
extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 200
        } else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        profileTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.RepositoriesViewControllerID) as! RepositoriesViewController
                reposVC.isProfile = true
                self.navigationController?.pushViewController(reposVC, animated: true)
            case 1:
                break
            case 2:
                break
            default:
                break
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profileTableView.dequeueReusableCell(withIdentifier: K.homeTableViewCell ) as! HomeTableViewCell
        cell.homeLabel.text = userDetailsArray[indexPath.row]
        cell.homeImage.image = imagesArray[indexPath.row]
        let userDetailsCell = profileTableView.dequeueReusableCell(withIdentifier: K.UserDetailsTableViewCellID) as! UserDetailsTableViewCell
        userDetailsCell.userFullNameLabel.text = user?.name
        if let userAvatarUrl = user?.avatar_url {
            userDetailsCell.userImage.kf.setImage(with: URL(string: "\(userAvatarUrl)"),placeholder: UIImage(named: "UsersIcon"))
        }
        userDetailsCell.userFullNameLabel.text = user?.login
        userDetailsCell.userNameLabel.text = user?.name
        userDetailsCell.userBioLabel.text = user?.bio ?? "Unavailable Bio"
        userDetailsCell.userLocation.text = user?.location ?? "Unavailable Location"
        userDetailsCell.userImage.layer.masksToBounds = false
        userDetailsCell.userImage.layer.cornerRadius = userDetailsCell.userImage.frame.height/2
        userDetailsCell.userImage.clipsToBounds = true
        if let userFollowing = user?.following {
            userDetailsCell.userFollowingLabel.text = "\(userFollowing)"
        }
        if let userFollowers = user?.followers {
            userDetailsCell.userFollowersLabel.text = "\(userFollowers)"
        }
        userDetailsCell.bookmarkButtonImage.isHidden = true
        if indexPath.section == 0 && indexPath.row == 0 {
            userDetailsCell.selectionStyle = .none
            return userDetailsCell
        } else {
            return cell
        }
    }
    
    
}

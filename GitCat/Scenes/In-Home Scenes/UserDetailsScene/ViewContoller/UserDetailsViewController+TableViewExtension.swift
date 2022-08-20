//
//  UserDetailsViewController+TableViewExtension.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//

import UIKit

extension UserDetailsViewController: UITableViewDelegate, UITableViewDataSource {
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = userDetailsTableView.dequeueReusableCell(withIdentifier: K.homeTableViewCell ) as! HomeTableViewCell
        let userDetailsCell = userDetailsTableView.dequeueReusableCell(withIdentifier: K.UserDetailsTableViewCellID) as! UserDetailsTableViewCell
        cell.homeLabel.text = userDetailsArray[indexPath.row]
        cell.homeImage.image = imagesArray[indexPath.row]
        if let userFollowing = user?.following {
            userDetailsCell.userFollowingLabel.text = "\(userFollowing)"
        }
        if let userFollowers = user?.followers {
            userDetailsCell.userFollowersLabel.text = "\(userFollowers)"
        }
        if let userAvatarUrl = user?.avatar_url {
            userDetailsCell.userImage.kf.setImage(with: URL(string: "\(userAvatarUrl)"),placeholder: UIImage(named: "UsersIcon"))
        }
        userDetailsCell.userFullNameLabel.text = user?.login
        userDetailsCell.userNameLabel.text = user?.name
        userDetailsCell.userBioLabel.text = user?.bio ?? "Unavailable Bio"
        userDetailsCell.userLocation.text = user?.location ?? "Unavailable Location"
        //print(user?.avatar_url)
        //var avatarURl =  URL(string: user!.avatar_url)
       // print(avatarURl)
       // userDetailsCell.userImage.kf.setImage(with: avatarURl, placeholder: UIImage(named: "UsersIcon"))
        userDetailsCell.userImage.layer.masksToBounds = false
        userDetailsCell.userImage.layer.cornerRadius = cell.homeImage.frame.height/1.1
        userDetailsCell.userImage.clipsToBounds = true
        if indexPath.section == 0 && indexPath.row == 0 {
            userDetailsCell.selectionStyle = .none
            return userDetailsCell
        } else {
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userDetailsTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 && indexPath.row == 0 {
            let reposVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.RepositoriesForUserViewControllerID) as! RepositoriesForUserViewController
            //userDetailsVC.passeedDataFromUserListVC = passedDataToUserDetailsVC
            self.navigationController?.pushViewController(reposVC, animated: true)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
          
        }
        if indexPath.section == 1 && indexPath.row == 2 {
          
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 200
        } else {
            return 50
        }
    }
}
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = self.userDetailsTableView.dequeueReusableHeaderFooterView(withIdentifier: K.UserDetailsHeaderID)
////        let label = UILabel(frame: CGRect(x: 120, y: 120, width: 150, height: 150))
////           label.text = "TEST TEXT"
////        label.textColor = .black
////        self.view.addSubview(label)
//       // self.view.addSubview(view!)
//        return view
//    }

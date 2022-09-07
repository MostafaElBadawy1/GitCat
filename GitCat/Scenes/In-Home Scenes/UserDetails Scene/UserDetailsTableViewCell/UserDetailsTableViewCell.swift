//
//  UserDetailsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
class UserDetailsTableViewCell: UITableViewCell {
    var delegate: TableViewCellDelegate?
   // let userBookmarkImage = UserDefaults.standard.bool(forKey: "userBookmarkImage")
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    @IBOutlet weak var bookmarkButtonImage: UIButton!
    
    @IBAction func bookmarkButton(_ sender: UIButton) {
        delegate?.addTapped(cell: self)
        //UserDefaults.standard.set( bookmarkButtonImage.isSelected , forKey: "userBookmarkImage")
        if bookmarkButtonImage.currentImage == UIImage(systemName: "star") {
            bookmarkButtonImage.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            bookmarkButtonImage.setImage(UIImage(systemName: "star"), for: .normal)
        }
        //  bookmarkButtonImage.setImage(UIImage(systemName: "star.fill"), for: .normal)
        //        UserDefaults.standard.set(sender.isSelected, forKey: "bookmarked")
        //        if bookmarkButtonImage.isSelected {
        //                   print("I am selected.")
        //            bookmarkButtonImage.setImage(UIImage(systemName: "star.fill"), for: .normal)
        //                   UserDefaults.standard.set(false, forKey: "starNotSelected")
        //                   UserDefaults.standard.set(true, forKey: "starSelected")
        //           } else {
        //               bookmarkButtonImage.setImage(UIImage(systemName: "star"), for: .normal)
        //                   UserDefaults.standard.set(false, forKey: "starSelected")
        //                   UserDefaults.standard.set(true, forKey: "starNotSelected")
        //
        //                   print("I am not selected.")
        //    }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
       // bookmarkButtonImage.isSelected = UserDefaults.standard.bool(forKey: "userBookmarkImage")
        //bookmarkButtonImage.isSelected = UserDefaults.standard.bool(forKey: "bookmarked")
        //configureUI()
        //        bookmarkButtonImage.isSelected = !bookmarkButtonImage.isSelected
        //        if UserDefaults.standard.bool(forKey: "starSelected") {
        //            bookmarkButtonImage.setImage(UIImage(systemName: "star.fill"), for: .normal)
        //            print("star selected")
        //        }
        //
        //        if UserDefaults.standard.bool(forKey: "starNotSelected") {
        //            bookmarkButtonImage.setImage(UIImage(systemName: "star"), for: .normal)
        //            print("star not selected")
        
        // }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}



protocol TableViewCellDelegate {
    func addTapped(cell: UserDetailsTableViewCell)
}

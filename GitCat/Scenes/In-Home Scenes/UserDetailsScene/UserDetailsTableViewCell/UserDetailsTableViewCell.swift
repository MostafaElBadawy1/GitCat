//
//  UserDetailsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    @IBOutlet weak var bookmarkButtonImage: UIButton!
    
    @IBAction func bookmarkButton(_ sender: Any) {
    User
        print("BookMark Pressed")
        //bookmarkButtonImage.imageView = UIImage("star.fill")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//
//  UserDetailsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//

import UIKit

class UserDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userJobTitleLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    
    @IBOutlet weak var bookmarkButtonImage: UIButton!
    
    @IBAction func bookmarkButton(_ sender: Any) {
        print("BookMark Pressed")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

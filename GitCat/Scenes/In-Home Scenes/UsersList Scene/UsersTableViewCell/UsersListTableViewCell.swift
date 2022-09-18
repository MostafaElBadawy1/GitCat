//
//  UsersListTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 21/07/2022.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {
    @IBOutlet weak var UserImageView: UIImageView!
    //var index: IndexPath?

    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  UsersListTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 21/07/2022.
//

import UIKit

class UsersListTableViewCell: UITableViewCell {
    @IBOutlet weak var UserImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

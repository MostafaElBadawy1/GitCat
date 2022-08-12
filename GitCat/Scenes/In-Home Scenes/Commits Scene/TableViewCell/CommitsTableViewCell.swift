//
//  CommitsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit

class CommitsTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commitMessageLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

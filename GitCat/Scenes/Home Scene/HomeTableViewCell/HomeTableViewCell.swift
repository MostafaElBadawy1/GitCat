//
//  HomeTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 05/08/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    

    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

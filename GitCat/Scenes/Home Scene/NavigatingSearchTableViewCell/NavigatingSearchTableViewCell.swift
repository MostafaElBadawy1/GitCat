//
//  NavigatingSearchTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 18/09/2022.
//
import UIKit
class NavigatingSearchTableViewCell: UITableViewCell {
    @IBOutlet weak var  navigatingLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

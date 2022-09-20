//
//  UserDetailsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
class UserDetailsTableViewCell: UITableViewCell {
    var delegate: TableViewCellDelegate?
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFullNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var userLocation: UILabel!
    @IBOutlet weak var userFollowersLabel: UILabel!
    @IBOutlet weak var userFollowingLabel: UILabel!
    @IBOutlet weak var bookmarkButtonImage: UIButton!
    
    @IBAction func bookmarkButton(_ sender: UIButton) {
        if bookmarkButtonImage.currentImage == UIImage(systemName: "star") {
            delegate?.addTapped(cell: self)
            bookmarkButtonImage.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            bookmarkButtonImage.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
protocol TableViewCellDelegate {
    func addTapped(cell: UserDetailsTableViewCell)
}

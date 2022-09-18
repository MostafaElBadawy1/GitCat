//
//  ExploreTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 30/08/2022.
//
import UIKit
class ExploreTableViewCell: UITableViewCell {
    var delegate: ExploreCellDelegate?
    var index: IndexPath?
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var descreptionLabel: UILabel!
    @IBOutlet weak var starImage: UIButton!
    @IBOutlet weak var starredNumLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBAction func bookmarkButton(_ sender: UIButton) {
        delegate?.addStarredCell(cell: self, index: index!.row)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
protocol ExploreCellDelegate {
    func addStarredCell(cell: ExploreTableViewCell, index: Int)
}

//
//  RepositoriesTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
class RepositoriesTableViewCell: UITableViewCell {
    var delegate: RepostableViewCellDelegate?
    var index: IndexPath?
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var starredNumberLabel: UILabel!
    @IBOutlet weak var programmingLangLabel: UILabel!
    @IBOutlet weak var languageIndicator: UIButton!
    @IBOutlet weak var bookmarkButtonImage: UIButton!
    
    @IBAction func bookmarkButton(_ sender: UIButton) {
        delegate?.addTappedCell(cell: self, index: index!.row)
        print("bookmark pressed")

    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
protocol RepostableViewCellDelegate {
    func addTappedCell(cell: RepositoriesTableViewCell, index: Int)
}

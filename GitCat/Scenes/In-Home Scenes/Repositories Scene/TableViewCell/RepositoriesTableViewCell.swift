//
//  RepositoriesTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
class RepositoriesTableViewCell: UITableViewCell {
    var delegate: RepostableCellDelegate?
    var index: IndexPath?
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var starredNumberLabel: UILabel!
    @IBOutlet weak var programmingLangLabel: UILabel!
    @IBOutlet weak var languageIndicator: UIButton!
    @IBOutlet weak var bookmarkButtonImage: UIButton!
    
    @IBAction func bookmarkButton(_ sender: UIButton) {
        delegate?.addTappedCell(cell: self, index: index!.row)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
protocol RepostableCellDelegate {
    func addTappedCell(cell: RepositoriesTableViewCell, index: Int)
}

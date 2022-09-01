//
//  CollectionViewTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 01/09/2022.
//
import UIKit
import Kingfisher
class CollectionViewTableViewCell: UITableViewCell {
    @IBOutlet weak var recentVisitedUsersCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCollectionView() {
        recentVisitedUsersCollectionView.delegate = self
        recentVisitedUsersCollectionView.dataSource = self
        recentVisitedUsersCollectionView.register(UINib(nibName: K.RecentVisitedUsersCollectionViewCellID , bundle: .main), forCellWithReuseIdentifier: K.RecentVisitedUsersCollectionViewCellID )
    }
}
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentVisitedUsersCollectionView.dequeueReusableCell(withReuseIdentifier: K.RecentVisitedUsersCollectionViewCellID, for: indexPath) as! RecentVisitedUsersCollectionViewCell
        cell.RecentVisitedUsersNameLabel.text =
        cell.RecentVisitedUsersImageView.kf.setImage(with: URL(string: ),placeholder: UIImage(named: "UsersIcon"))
        return cell
    }
    
    
}

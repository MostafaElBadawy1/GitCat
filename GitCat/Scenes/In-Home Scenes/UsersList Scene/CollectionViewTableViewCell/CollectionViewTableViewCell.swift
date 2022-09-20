//
//  CollectionViewTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 01/09/2022.
//
import UIKit
import Kingfisher
class CollectionViewTableViewCell: UITableViewCell {
    var visitedUserArray = [VisitedUser]()
    var usersListViewController = UsersListViewController()
    var delegate: CollectionViewTableViewCellDelegate?
    var index: IndexPath?
    @IBOutlet weak var recentVisitedUsersCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        fetchVisitedUsers()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func configCollectionView() {
        recentVisitedUsersCollectionView.delegate = self
        recentVisitedUsersCollectionView.dataSource = self
        recentVisitedUsersCollectionView.register(UINib(nibName: K.RecentVisitedUsersCollectionViewCellID , bundle: .main), forCellWithReuseIdentifier: K.RecentVisitedUsersCollectionViewCellID )
    }
    func fetchVisitedUsers() {
        CoreDataManger.shared.fetch(entityName: VisitedUser.self) { (users, error) in
            if let users = users {
                self.visitedUserArray = users
                DispatchQueue.main.async {
                    self.recentVisitedUsersCollectionView.reloadData()
                }
            }
        }
    }

}
extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, canEditItemAt indexPath: IndexPath) -> Bool {
//        <#code#>
//    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(visitedUserArray.count)
        return visitedUserArray.count
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tappedCell(cell: self, index: indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = recentVisitedUsersCollectionView.dequeueReusableCell(withReuseIdentifier: K.RecentVisitedUsersCollectionViewCellID, for: indexPath) as! RecentVisitedUsersCollectionViewCell
        cell.RecentVisitedUsersNameLabel.text = visitedUserArray[indexPath.item].userName
        cell.RecentVisitedUsersImageView.kf.setImage(with: visitedUserArray[indexPath.item].userImageURL ,placeholder: UIImage(named: "UsersIcon"))
        cell.RecentVisitedUsersImageView.layer.masksToBounds = false
        cell.RecentVisitedUsersImageView.layer.cornerRadius = cell.RecentVisitedUsersImageView.frame.height/2
        cell.RecentVisitedUsersImageView.clipsToBounds = true
        return cell
    }
}
extension CollectionViewTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100 , height: 120 )
    }
}

protocol CollectionViewTableViewCellDelegate  {
    func tappedCell(cell: CollectionViewTableViewCell, index: Int)
}

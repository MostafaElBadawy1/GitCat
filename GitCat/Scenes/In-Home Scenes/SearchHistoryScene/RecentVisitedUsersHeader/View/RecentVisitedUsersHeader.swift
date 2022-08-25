//
//  RecentVisitedUsersHeader.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 23/08/2022.
//
import UIKit
class RecentVisitedUsersHeader: UIView {
    // MARK: - Properties
   // var recentVisitedUsersCollectionView = UICollectionView()
let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(named: "GitHubIcon")
        return iv
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        let profileImageDimension: CGFloat = 60
        addSubview(profileImageView)
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: profileImageDimension).isActive = true
        profileImageView.layer.cornerRadius = profileImageDimension / 2
        
        addSubview(usernameLabel)
        usernameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: -10).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12).isActive = true
        
//        recentVisitedUsersCollectionView.dataSource = self
//        recentVisitedUsersCollectionView.delegate = self
//        recentVisitedUsersCollectionView.register(UINib(nibName: K.RecentVisitedUsersCollectionViewCellID, bundle: .main), forCellWithReuseIdentifier: K.RecentVisitedUsersCollectionViewCellID)
//        //recentVisitedUsersCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: <#T##String#>)
//        recentVisitedUsersCollectionView.backgroundColor = UIColor.white
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 10, height: 10)
//        layout.scrollDirection = .horizontal
//        recentVisitedUsersCollectionView = UICollectionView(frame: CGRect(x: 20, y: 20, width: 100, height: 100), collectionViewLayout: layout)
        //addSubview(recentVisitedUsersCollectionView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//extension RecentVisitedUsersHeader : UICollectionViewDelegate, UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 1
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = recentVisitedUsersCollectionView.dequeueReusableCell(withReuseIdentifier: K.RecentVisitedUsersCollectionViewCellID, for: indexPath) as! RecentVisitedUsersCollectionViewCell
//        cell.RecentVisitedUsersNameLabel.text = "sasa"
//        return cell
//    }
//}
//extension RecentVisitedUsersHeader: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let leftAndRightPaddings: CGFloat = 1
//        let numberOfItemsPerRow: CGFloat = 2.0
//        let width = (collectionView.frame.width-leftAndRightPaddings)/numberOfItemsPerRow
//        return CGSize(width: width, height: 160)
//    }
//}

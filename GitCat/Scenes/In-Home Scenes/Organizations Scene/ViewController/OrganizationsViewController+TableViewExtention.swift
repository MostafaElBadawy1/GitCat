//
//  OrganizationsViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 26/08/2022.
//
import UIKit
extension OrganizationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgsArray.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        orgsTableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orgsTableView.dequeueReusableCell(withIdentifier: K.OrganizationsTableViewCellID) as! OrganizationsTableViewCell
        cell.orgNameLabel.text = orgsArray[indexPath.row].login
        cell.orgDescriptionLabel.text = orgsArray[indexPath.row].description
        cell.orgImageView.kf.setImage(with: URL(string: orgsArray[indexPath.row].avatar_url!), placeholder: UIImage(named: "Organization"))
        return cell
    }
}

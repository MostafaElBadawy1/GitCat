//
//  CommitsViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 12/08/2022.
//

import UIKit

extension CommitsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        commitsTableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = commitsTableView.dequeueReusableCell(withIdentifier: K.CommitsTableViewCellID, for: indexPath)
        return cell
    }
}

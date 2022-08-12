//
//  CommitsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit

class CommitsViewController: UIViewController {
    @IBOutlet weak var commitsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    func tableViewConfig() {
        commitsTableView.delegate = self
        commitsTableView.dataSource = self
        commitsTableView.register(UINib(nibName: K.CommitsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.CommitsTableViewCellID)
        commitsTableView.frame = view.frame
    }
}

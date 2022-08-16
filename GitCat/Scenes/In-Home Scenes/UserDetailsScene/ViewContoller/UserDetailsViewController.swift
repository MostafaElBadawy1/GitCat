//
//  UserDetailsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 08/08/2022.
//

import UIKit
class UserDetailsViewController: UIViewController {
    let userDetailsArray = ["Repositories","Starred","Organization"]
    let imagesArray = [UIImage(named: "repoIcon"),UIImage(named: "Star"),UIImage(named: "Organization")]
    @IBOutlet weak var userDetailsTableView: UITableView!
    @IBAction func safariViewButton(_ sender: UIBarButtonItem) {
        print("safariBtn")
    }
    @IBAction func shareUserButton(_ sender: UIBarButtonItem) {
        print("shareBtn")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
    }
    func tableViewConfig() {
        userDetailsTableView.delegate = self
        userDetailsTableView.dataSource = self
        userDetailsTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        userDetailsTableView.register((UINib(nibName: K.UserDetailsTableViewCellID, bundle: .main)), forCellReuseIdentifier: K.UserDetailsTableViewCellID)
        userDetailsTableView.frame = view.frame
    }
}
//        userDetailsTableView.frame = view.frame
        //        let header = UIView(frame: CGRect(x: 120, y: 100, width: view.frame.size.width, height: 150))
        //        userDetailsTableView.tableHeaderView = header
        //        header.backgroundColor = .green  

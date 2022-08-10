//
//  ProfileViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    let userDetailsArray = ["Repositories","Starred","Organization"]
    let imagesArray = [UIImage(named: "repoIcon"),UIImage(named: "Star"),UIImage(named: "Organization")]
    
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBAction func settingButton(_ sender: UIBarButtonItem) {
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    @IBAction func shareLink(_ sender: UIBarButtonItem) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: K.UserDetailsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.UserDetailsTableViewCellID)
        profileTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
    }
}



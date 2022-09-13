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
    var isLoggedIn: Bool {
      if TokenManager.shared.fetchAccessToken() != nil {
        return true
      }
      return false
    }
    @IBOutlet weak var shareLinkButton: UIButton!
    @IBOutlet weak var profileTableView: UITableView!
    @IBAction func settingButton(_ sender: UIBarButtonItem) {
        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.SettingsViewControllerID) as! SettingsViewController
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    @IBAction func shareLink(_ sender: UIBarButtonItem) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn {
            tableViewConfig()
        } else {
            orgsLabelConfig()
            shareLinkButton.isHidden = true
        }
    }
    func tableViewConfig() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: K.UserDetailsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.UserDetailsTableViewCellID)
        profileTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        profileTableView.frame = view.frame
    }
    func orgsLabelConfig(){
        let label = UILabel()
        label.text = "Not Logged In"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.frame =  CGRect(x: 130, y: 400, width:300, height: 50)
        self.view.addSubview(label)
    }
}



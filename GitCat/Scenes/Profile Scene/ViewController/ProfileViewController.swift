//
//  ProfileViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 09/08/2022.
//
import UIKit
import Kingfisher
class ProfileViewController: UIViewController {
    var profileViewModel = ProfileViewModel()
    let userDetailsArray = ["Repositories","Starred","Organization"]
    let imagesArray = [UIImage(named: "repoIcon"),UIImage(named: "Star"),UIImage(named: "Organization")]
    var user : UserModel?
    let loadingIndicator = UIActivityIndicatorView()
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
        presentShareSheet()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if isLoggedIn {
            tableViewConfig()
            fetchUserData ()
        } else {
            LabelConfig()
            //shareLinkButton.isHidden = true
        }
    }
    func tableViewConfig() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
        profileTableView.register(UINib(nibName: K.UserDetailsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.UserDetailsTableViewCellID)
        profileTableView.register(UINib(nibName: K.homeTableViewCell, bundle: .main), forCellReuseIdentifier: K.homeTableViewCell)
        profileTableView.frame = view.frame
    }
    func LabelConfig(){
        let label = UILabel()
        label.text = "Not Logged In"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        //label.translatesAutoresizingMaskIntoConstraints = false
        label.frame =  CGRect(x: 130, y: 400, width:300, height: 50)
        self.view.addSubview(label)
    }
    private func presentShareSheet() {
        let image = UIImageView()
        guard let url = URL(string: (user?.html_url)!) else {
            return
        }
        image.kf.setImage(with: URL(string: (user?.avatar_url!)!),placeholder: UIImage(named: "UsersIcon"))
        let shareSheetVC = UIActivityViewController(activityItems: [image, url], applicationActivities: nil)
        present(shareSheetVC, animated: true)
    }
    
    func fetchUserData () {
        self.loadingIndicator.startAnimating()
        self.profileTableView.isHidden = true
        profileViewModel.fetchUserDetails()
        profileViewModel.bindingData = { userData, error in
            if let user = userData {
                self.user = user
                DispatchQueue.main.async {
                    self.profileTableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    self.profileTableView.isHidden = false
                }
            }
            if let error = error {
                print(error)
            }
        }
    }
}



//
//  SettingsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//
import UIKit
class SettingsViewController: UIViewController {
    var userInfoHeader: UserInfoHeader!
    var usersModel = [User]()
    var reposModel = [Repo]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var SettingsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        configureUI()
    }
    func tableViewConfig() {
        SettingsTableView.delegate = self
        SettingsTableView.dataSource = self
        SettingsTableView.rowHeight = 45
        SettingsTableView.register(UINib(nibName: K.SettingsTableViewCellID, bundle: .main), forCellReuseIdentifier: K.SettingsTableViewCellID)
        SettingsTableView.frame = view.frame
        //SettingsTableView.tableHeaderView.
       // SettingsTableView.tableFooterView = UIView()
        //SettingsTableView.tableHeaderView?.isHidden = true
    }
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        headerConfig()
        // navigationController?.navigationBar.isTranslucent = false
         //navigationController?.navigationBar.barStyle = .black
        // navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
    }
    func headerConfig(){
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 80)
        userInfoHeader = UserInfoHeader(frame: frame)
        SettingsTableView.tableHeaderView = userInfoHeader
        SettingsTableView.tableHeaderView?.backgroundColor = .systemGray6
    }
    func clearBookmarks()  {
        do
        {
            try CoreDataManger.shared.clearBookmarks()
        } catch {
            print(error)
        }
    }
    func logOut() {
        let alert = UIAlertController(title: "Are You Sure You Want To Sign Out? ", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            TokenManager.shared.clearAccessToken()
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.loginViewControllerID) as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title:"No", style: .default, handler: { _ in
        }))
        self.present(alert, animated: true, completion: nil)
 
    }
}

//let alert = UIAlertController(title: "Are You Sure You Want To Sign Out? ", message: "", preferredStyle: .alert)
//alert.addAction(UIAlertAction(title: "Sign in with GitHub", style: .default, handler: { _ in
//    self.getGitHubIdentity()
//}))
//
//alert.addAction(UIAlertAction(title:"Cancel", style: .default, handler: { _ in
//}))
//self.present(alert, animated: true, completion: nil)

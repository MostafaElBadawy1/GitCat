//
//  SettingsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//
import UIKit
import CoreData
class SettingsViewController: UIViewController {
    var userInfoHeader : UserInfoHeader?
    var usersModel = [User]()
    var reposModel = [Repo]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var passedDataFromProfileVC : UserModel?
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
    }
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
    }
    func headerConfig(){
       // print(passedDataFromProfileVC?.name)
        //if let userData = passedDataFromProfileVC {
        userInfoHeader?.usernameLabel.textColor = .red
       // userInfoHeader.userIDLabel.text = "\(passedDataFromProfileVC?.id)"
       // }
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 80)
        userInfoHeader = UserInfoHeader(frame: frame)
        
        SettingsTableView.tableHeaderView = userInfoHeader
        SettingsTableView.tableHeaderView?.backgroundColor = .systemGray6
    }
//    func clearBookmarks()  {
////        let fetchRequest = NSFetchRequest(entityName: User)
////
////        // Configure Fetch Request
////        fetchRequest.includesPropertyValues = false
////
////        do {
////            let items = try managedObjectContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
////
////            for item in items {
////                managedObjectContext.deleteObject(item)
////            }
////
////            // Save Changes
////            try managedObjectContext.save()
////
////        } catch {
////            // Error Handling
////            // ...
////        }
//        do
//        {
//            try CoreDataManger.shared.clearBookmarks()
//        } catch {
//            print(error)
//        }
//    }
    func logOut() {
        let alert = UIAlertController(title: "Are You Sure You Want To Signout? ", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"No", style: .destructive, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            TokenManager.shared.clearAccessToken()
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: K.loginViewControllerID) as! LoginViewController
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}


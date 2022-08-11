//
//  SettingsViewController.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    var userInfoHeader: UserInfoHeader!
    @IBOutlet weak var SettingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureUI()
    }
    func configureTableView() {
        SettingsTableView.delegate = self
        SettingsTableView.dataSource = self
        SettingsTableView.rowHeight = 45
        SettingsTableView.register(UINib(nibName: "SettingsTableViewCell", bundle: .main), forCellReuseIdentifier: "SettingsTableViewCell")
        SettingsTableView.frame = view.frame
        
        let frame = CGRect(x: 0, y: 88, width: view.frame.width, height: 80)
        userInfoHeader = UserInfoHeader(frame: frame)
        SettingsTableView.tableHeaderView = userInfoHeader
        SettingsTableView.tableHeaderView?.backgroundColor = .systemGray6
        //SettingsTableView.tableHeaderView.
       // SettingsTableView.tableFooterView = UIView()
        //SettingsTableView.tableHeaderView?.isHidden = true
    }
    
    func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Settings"
        // navigationController?.navigationBar.isTranslucent = false
         //navigationController?.navigationBar.barStyle = .black
        // navigationController?.navigationBar.barTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
    }
}
extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 40
        default:
            return 25
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return SettingsSection(rawValue: section)?.description
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else {return 0}
        switch section {
        case .General:
            return GeneralOptions.allCases.count
        case .Policy:
            return PolicyOptions.allCases.count
        case .Language:
            return LanguageOptions.allCases.count
        case .Account:
            return AccountOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SettingsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsTableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        guard let section = SettingsSection(rawValue: indexPath.section) else {return UITableViewCell()}
        switch section {
        case .General:
            let general = GeneralOptions(rawValue: indexPath.row)
            cell.textLabel?.text = general?.description
        case .Policy:
            let policy = PolicyOptions(rawValue: indexPath.row)
            cell.textLabel?.text = policy?.description
        case .Language:
            let language = LanguageOptions(rawValue: indexPath.row)
            cell.textLabel?.text = language?.description
        case .Account:
            let account = AccountOptions(rawValue: indexPath.row)
            cell.textLabel?.text = account?.description
        }
        if indexPath.section == 0 && indexPath.row == 0{
            cell.switchControl.isHidden = false
        } else {
            cell.switchControl.isHidden = true
        }
//        if indexPath.section == 3 && indexPath.row == 0{
//            cell.settingsLabel.textColor = .red
//        } else {
//            cell.settingsLabel.textColor = .black
//        }

        return cell
    }
}

//
//  SettingsViewController+TableViewExtention.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 23/08/2022.
//
import UIKit
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
        guard let section = SettingsSection(rawValue: indexPath.section) else {return}
        switch section {
        case .General:
            switch indexPath.row {
            case 2 :
                clearBookmarks()
            default:
                break
            }
        default:
            break
        }
        
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
        if indexPath.section == 3 && indexPath.row == 0{
            cell.textLabel?.textColor = .red
        } else {
            cell.textLabel?.textColor = .label
        }
        return cell
    }
}

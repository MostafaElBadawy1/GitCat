//
//  SettingsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//
import UIKit
class SettingsTableViewCell: UITableViewCell {
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    @IBOutlet weak var switchControl: UISwitch!
    @IBAction func switchDidChange(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkMode")
        let window = UIApplication.shared.windows[0]
        if sender.isOn{
            window.overrideUserInterfaceStyle = .dark
        } else {
            window.overrideUserInterfaceStyle = .light
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        switchControl.isOn = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

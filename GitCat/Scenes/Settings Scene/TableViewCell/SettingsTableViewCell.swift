//
//  SettingsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    //let userDefaults = UserDefaults.standard
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
   
    
    @IBOutlet weak var switchControl: UISwitch!
    @IBAction func switchDidChange(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkMode")
        let window = UIApplication.shared.windows[0]
        if sender.isOn{
            //UserDefaults.standard.set(true, forKey: "isDarkMode")
            window.overrideUserInterfaceStyle = .dark
            //sender.isOn = true
        } else {
            //UserDefaults.standard.set(false, forKey: "isDarkMode")
            //sender.isOn = false
            window.overrideUserInterfaceStyle = .light
        }
    }
  
  
    override func awakeFromNib() {
        super.awakeFromNib()
        switchControl.isOn = UserDefaults.standard.bool(forKey: "isDarkMode")
//        let window = UIApplication.shared.windows[0]
//        if switchControl.isOn {
//            window.overrideUserInterfaceStyle = .dark
//        } else {
//            window.overrideUserInterfaceStyle = .light
//        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    //switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
    //addSubview(switchControl)
//        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        switchControl.rightAnchor.constraint(equalTo: rightAnchor,constant: -12).isActive = true
}

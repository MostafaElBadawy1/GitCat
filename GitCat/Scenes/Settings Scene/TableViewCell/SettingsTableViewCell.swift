//
//  SettingsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults.standard
    @IBOutlet weak var switchControl: UISwitch!
    @IBAction func switchDidChange(_ sender: UISwitch) {
        let window = UIApplication.shared.windows[0]
        if sender.isOn {
            window.overrideUserInterfaceStyle = .dark
            userDefaults.set(switchControl.isOn, forKey: "SwitchControlState")
            //userDefaults.set(window.overrideUserInterfaceStyle = .dark, forKey: "AppAppearanceStateDark")
        } else {
            window.overrideUserInterfaceStyle = .light
           // userDefaults.set(window.overrideUserInterfaceStyle = .dark, forKey: "AppAppearanceStateLight")
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        switchControl.isOn = userDefaults.bool(forKey: "SwitchControlState")
       // switchControl.isOn = userDefaults.bool(forKey: "AppAppearanceStateDark")
       // switchControl.isOn = userDefaults.bool(forKey: "AppAppearanceStateLight")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        switchControl.isOn = userDefaults.bool(forKey: "SwitchControlState")
    }
//    @objc func handleSwitchAction(sender: UISwitch){

//        if sender.isOn {
//            print("Turned on")
//        }
//        else{
//            print("Turned off")
//        }
//    }
    //switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
    //addSubview(switchControl)
//        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        switchControl.rightAnchor.constraint(equalTo: rightAnchor,constant: -12).isActive = true
}

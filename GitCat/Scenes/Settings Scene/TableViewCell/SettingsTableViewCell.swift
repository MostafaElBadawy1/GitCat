//
//  SettingsTableViewCell.swift
//  GitCat
//
//  Created by Mostafa Elbadawy on 10/08/2022.
//

import UIKit
import SwiftUI

class SettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var switchControl: UISwitch!
    @IBAction func switchDidChange(_ sender: UISwitch) {
        if sender.isOn {
            print("turned ON")
            overrideUserInterfaceStyle = .dark
        } else {
            print("turned Off")
            overrideUserInterfaceStyle = .light
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        //switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        //addSubview(switchControl)
//        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//        switchControl.rightAnchor.constraint(equalTo: rightAnchor,constant: -12).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    
    
    
    
    
    
//    @objc func handleSwitchAction(sender: UISwitch){

//        if sender.isOn {
//            print("Turned on")
//        }
//        else{
//            print("Turned off")
//        }
//    }

    
}

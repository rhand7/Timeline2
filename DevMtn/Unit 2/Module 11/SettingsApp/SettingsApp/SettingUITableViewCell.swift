//
//  SettingUITableViewCell.swift
//  SettingsApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

protocol SettingsTableViewCellDelegate: class {                //1. Create delegate protocol: class
    
    func settingValueChange(_ cell: SettingUITableViewCell, isSelected: Bool)   //3. func determines if cell value changed
}

class SettingUITableViewCell: UITableViewCell {
    
    //MARK: IB Properties
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var settingSwitch: UISwitch!
    
    //MARK: Internal Properties
    
    weak var delegate: SettingsTableViewCellDelegate?         //2. Delegate is equal to SettingsVCtrl - Create delegate weak optional
    
    var setting: Setting? {
        didSet {
            guard let setting = setting else { return } //if doesn't exist, return early
            iconImageView.image = setting.image    //if it does exist set our iconImageView
            settingLabel.text = setting.name
            settingSwitch.isOn = setting.isSet
            backgroundColor = setting.isSet ? .yellow : .white  //condensed version of below code 
//            if setting.isSet {
//                backgroundColor = .yellow
//            } else {
//                backgroundColor = .white
//            }
        }
        
    }

    
    //MARK: Internal Methods
    
    @IBAction func settingSwitchValueChanged(_ sender: Any) {
    delegate?.settingValueChange(self, isSelected: settingSwitch.isOn)  //6. setting the action for delegate, properties are from SettingsVCtrl.settingValueChange and passed to VC
    }
}

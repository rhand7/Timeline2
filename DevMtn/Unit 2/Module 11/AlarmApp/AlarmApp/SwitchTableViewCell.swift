//
//  SwitchTableViewCell.swift
//  AlarmApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {                                        //1. Create delegate protocol: class
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)                     //2. Define func for switch
}

class SwitchTableViewCell: UITableViewCell {
    
    //MARK: IB Properties
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    //MARK: Internal Properties
    
    weak var delegate: SwitchTableViewCellDelegate?                                   //3. Create delegate = to SwitchVCtrl
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    
    
    //MARK: Actions
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)    //4. Update to check if delegate is assigned, if so, call the delegate protocol
    }
    
    func updateViews() {
        guard let alarm = alarm else { return }
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
    }
}



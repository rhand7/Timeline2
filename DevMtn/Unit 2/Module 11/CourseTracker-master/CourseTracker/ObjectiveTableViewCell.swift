//
//  ObjectiveTableViewCell.swift
//  CourseTracker
//
//  Created by handje on 4/1/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

//define new custom protocol for switch, (add : class to prevent a retain cycle). In the protocol we define a new func + properties that someone else is going to follow and implement.

protocol ObjectiveTableViewCellDelegate: class {
    
    func masterySwitchValueChangeOnCell(cell: ObjectiveTableViewCell)        //this method calls everytime switch is changed
}

class ObjectiveTableViewCell: UITableViewCell {

    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var masterySwitch: UISwitch!
    weak var delegate: ObjectiveTableViewCellDelegate?   //var delegate communicates through the DTbVC
    
    
    @IBAction func masterySwitchValueChanged(_ sender: UISwitch) {
        
        delegate?.masterySwitchValueChangeOnCell(cell: self)  //this is the receiver, the instance of ObjTbVC
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

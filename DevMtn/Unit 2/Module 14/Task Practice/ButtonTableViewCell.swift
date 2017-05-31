//
//  ButtonTableViewCell.swift
//  Task Practice
//
//  Created by handje on 4/6/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var checkboxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    var task: Task? {
        didSet {
            updateViews() 
        }
    }
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBAction func checkboxButtonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(sender: self) 
    }
    
    func updateViews() {
        guard let task = task else { return }
        
        self.nameLabel.text = task.name
        
        if task.isComplete == false {
            checkboxButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        } else {
            checkboxButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        }
    }
}

protocol ButtonTableViewCellDelegate {                          //tells VC to tell M that button has changed on the V
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
}

//
//  ButtonTableViewCell.swift
//  TaskApp
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    //MARK: Action
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self) 
    }
    
    //MARK: Private
    
    fileprivate func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }

    //MARK: Properties
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var primaryLabel: UILabel!
    

}

extension ButtonTableViewCell {
    func update(withTask task: Task) {
        
        primaryLabel.text = task.name
        updateButton(task.isComplete)
    }
}

protocol ButtonTableViewCellDelegate {
     func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
}

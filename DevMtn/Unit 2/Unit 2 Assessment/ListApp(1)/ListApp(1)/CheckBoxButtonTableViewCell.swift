//
//  CheckBoxButtonTableViewCell.swift
//  ListApp(1)
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit
import CoreData

//MARK: Delegate Protocol

protocol CheckBoxButtonTableViewCellDelegate {
    func checkBoxCellButtonTapped(sender: CheckBoxButtonTableViewCell)
}

class CheckBoxButtonTableViewCell: UITableViewCell {
    
    var delegate: CheckBoxButtonTableViewCellDelegate?
    var listItem: ListItem? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: IB Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    
    //MARK: IB Action
    
    @IBAction func checkBoxButtonTapped(_ sender: Any) {
        delegate?.checkBoxCellButtonTapped(sender: self)
    }
    
    //MARK: updateViews()
    
    func updateViews() {
        guard let listItem = listItem else { return }
        self.nameLabel.text = listItem.name
        
        if listItem.isComplete == false {
            checkBoxButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        } else {
            checkBoxButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        }
    }
}

extension CheckBoxButtonTableViewCell {
    func updateList(listItem: ListItem) {
        nameLabel.text = listItem.name
        checkBoxButtonTapped(listItem.isComplete)
    }
}

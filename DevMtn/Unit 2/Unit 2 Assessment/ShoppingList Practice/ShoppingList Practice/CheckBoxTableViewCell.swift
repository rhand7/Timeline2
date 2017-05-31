//
//  CheckBoxTableViewCell.swift
//  ShoppingList Practice
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit
import CoreData


//MARK: Delegate Protocol
protocol CheckBoxTableViewCellDelegate {
    func checkboxCellButtonTapped(sender: CheckBoxTableViewCell)
}

class CheckBoxTableViewCell: UITableViewCell {

    //MARK: Properties
    
    var delegate: CheckBoxTableViewCellDelegate?
    var listItem: ListItem? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: IB Outlets 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    //MARK: IB Actions
    @IBAction func checkboxButtonTapped(_ sender: Any) {
        delegate?.checkboxCellButtonTapped(sender: self)
    }
    
    //MARK: updateViews
    
    func updateViews() {
        guard let listItem = listItem else { return }
        
        self.nameLabel.text = listItem.name
        
        if listItem.isComplete == false {
            checkboxButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        } else {
            checkboxButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        }
    }
}

extension CheckBoxTableViewCell {
    func updateList(listItem: ListItem) {
        nameLabel.text = listItem.name
        checkboxButtonTapped(listItem.isComplete) 
    }
}

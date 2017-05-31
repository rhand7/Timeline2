//
//  ButtonTableViewCell.swift
//  Unit 2 Assessment - ShoppingList
//
//  Created by handje on 4/7/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    
    //MARK: IB Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkboxButton: UIButton!
    
    //MARK: IB Actions
    
    @IBAction func checkboxButtonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(sender: self)    //4. msg sent from BTbVCell to delegate(self) comm to C to tell V
    }
    
    func updateViews() {                                             //7. updateViews()
        guard let item = item else { return }
        
        self.nameLabel.text = item.name
    
        if item.isComplete == false {
            checkboxButton.setImage(#imageLiteral(resourceName: "incomplete"), for: .normal)
        } else {
            checkboxButton.setImage(#imageLiteral(resourceName: "complete"), for: .normal)
        }
    }
    
    //MARK: Properties
    
    var delegate: ButtonTableViewCellDelegate?                          //2. create delegate
    
    var item: Item? {
        didSet {
            updateViews()                                             //7.
        }
    }
    
}

//MARK: Delegate Protocol
protocol ButtonTableViewCellDelegate {                                  //1. tells VC+MC to tell M, button has changed on V
    func buttonCellButtonTapped(sender: ButtonTableViewCell)
}

extension ButtonTableViewCell {
    func updateList(listItem: Item) {
        nameLabel.text = item?.name
        checkboxButtonTapped(listItem.isComplete)
    }
}

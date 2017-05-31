//
//  SendingVC.swift
//  DelegatePractive
//
//  Created by handje on 4/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

protocol DataSentDelegate {
    func userDidEnterData(data: String)
}

class SendingVC: UIViewController {
    
    var delegate: DataSentDelegate? = nil
    
    @IBOutlet weak var dataEntryTextField: UITextField!
    
    @IBAction func sendButtonPressed(_ sender: Any) {
        if delegate != nil {
            if dataEntryTextField.text != nil {
                let data = dataEntryTextField.text
                delegate?.userDidEnterData(data: data!)
                dismiss(animated: true, completion: nil) 
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

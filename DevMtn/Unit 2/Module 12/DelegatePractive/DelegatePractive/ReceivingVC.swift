//
//  ViewController.swift
//  DelegatePractive
//
//  Created by handje on 4/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ReceivingVC: UIViewController, DataSentDelegate {

    @IBOutlet weak var receivingTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func userDidEnterData(data: String) {
        receivingTextField.text = data 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSendingVC" {
            let sendingVC: SendingVC = segue.destination as! SendingVC
            sendingVC.delegate = self 
        }
    }

}


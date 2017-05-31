//
//  ViewController.swift
//  Alert Practice
//
//  Created by handje on 4/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func showAlert(_ sender: Any) {
        
        let alert = UIAlertController(title: "Registration", message: "Enter your name", preferredStyle: .alert)
        
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "Your name"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction) in
            
            if let textField = alert.textFields?.first {
                if textField.text == "" {
                    print("You have to enter something first")
                } else {
                    print("Hello \(String(describing: textField.text))")
                }
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func showActionSheet(_ sender: Any) {
        
    }
    
}


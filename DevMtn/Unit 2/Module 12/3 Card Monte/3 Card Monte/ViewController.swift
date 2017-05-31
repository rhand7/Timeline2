//
//  ViewController.swift
//  3 Card Monte
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let alertController = UIAlertController(title: "Welcome to 3 Card Monte", message: "One button is the winner. Can you pick the right one?", preferredStyle: .alert)
        
        let destructiveAction = UIAlertAction(title: "Is it this one??", style: .destructive) { destructiveAlert -> Void in self.youWin()
        }
        
        let defaultAction = UIAlertAction(title: "Could it be here??", style: .default) { defaultAlert -> Void in self.youLose()
        }
        
        let cancelAction = UIAlertAction(title: "Maybe this one??", style: .cancel) { cancelAler -> Void in self.youLose()
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        alertController.addAction(destructiveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func youWin() {
        let alertController = UIAlertController(title: "You WIN!", message: "Want to play again?", preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "No", style: .default) {
            defaultAlert -> Void in
            print("User decided to stop")
        }
        
        let cancelAction = UIAlertAction(title: "Yes", style: .cancel) {
            canelAlert -> Void in
            self.viewDidAppear(true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func youLose() {
        let alertController = UIAlertController(title: "You Lose :(", message: "Want to play again?", preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "No", style: .default) {
            defaultAlert -> Void in
            print("User chose to stop")
        }
        
        let cancelAction = UIAlertAction(title: "Yes", style: .cancel) {
            cancelAlert -> Void in
            self.viewDidAppear(true)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


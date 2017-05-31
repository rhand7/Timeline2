//
//  ViewController.swift
//  Notifications
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        NSNotification.defaultCenter().addObserver(self, selector: "localNotificationFired", name: "Notification", object: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func notifyMe(_ sender: Any) {
        
        let notif = UNNotificationRequest()
        notif.alertBody = "Body: You've been notified"
        notif.alertTitle = "Title: I'm the title"
        notif.fireDate = NSDate().addingTimeInterval(5) as Date
        
        UIApplication.shared.scheduleLocalNotification(notif)  
    }
    
    func localNotificationFired() {
       
        let alertController = UIAlertController(title: "Woah", message: "A notification", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(action) 
        
        presentedViewController(alertController, animated: true, completion: nil)
    }
}


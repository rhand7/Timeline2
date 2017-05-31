//
//  TimerViewController.swift
//  PowerNapTimer
//
//  Created by handje on 4/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit
import UserNotifications               //1n. import notifications

class TimerViewController: UIViewController {
    
    //MARK: IB Outlets
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    let myTimer = MyTimer() //create instance of MyTimer
    fileprivate let userNotificationIdentifier = "timerNotification"   //2n. create fileprivate notif id
    
    //MARK: IB Actions
    
    @IBAction func startButtonTapped(_ sender: Any) {
        if myTimer.isOn {
            myTimer.stopTimer()
            canelLocalNotification()         //6n.
        } else {
            myTimer.startTimer(5.0)
            scheduleLocalNotification()      //7n.
        }
        
        setView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        myTimer.delegate = self             //4d. use delegate to update UI after conforming VC to delegate protocol
        
//        setUpAlertController()          //2a. add alert controller to viewDidLoad
        
        //        myTimer.startTimer(5.0)   //testing timer - shows up in console
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTimer()                                   //can only have certain amt of notifications, hence the reset 
    }
    
    func setView() {                     //updates timer and whether label reads start nap or cancel
        updateTimerLabel()
        if myTimer.isOn {
            startButton.setTitle("Cancel", for: .normal)
        } else {
            startButton.setTitle("Start Nap", for: .normal)
        }
        
    }
    
    func resetTimer() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { (requests) in
            let timerLocalNotifications = requests.filter { $0.identifier == self.userNotificationIdentifier } //returns Boolean value, if true we grab the last request, false we exit early
            guard let timerNotificationRequest = timerLocalNotifications.last,
                let trigger = timerNotificationRequest.trigger as? UNCalendarNotificationTrigger,  //trigger allows us to get the date
            let fireDate = trigger.nextTriggerDate() else { return }  //must unwrap trigger to get our fireDate
            
            self.myTimer.stopTimer()
            self.myTimer.startTimer(fireDate.timeIntervalSinceNow)
        }
    }
    
    func updateTimerLabel() {            //update 00:00 label with Int data converted to String 
        timerLabel.text = myTimer.asString()
    }
    
    //MARK: AlertController
    
    func setUpAlertController() {                   //1a. set up AlertController func
        
        var snoozeTextField: UITextField?           //9a. add var snooze text
        
        let alert = UIAlertController(title: "Wake Up!", message: "Get Up!", preferredStyle: .alert)
        
        alert.addTextField { (textField) in                                //UIAlertCtrl gives us access to textField
            textField.placeholder = "Sleep a few more minutes..."          //alert option message
            textField.keyboardType = .numberPad                            //allow user to change time not text
            snoozeTextField = textField
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { _ in   //4a. add dismiss button
            
        }
        
        let snoozeAction = UIAlertAction(title: "Snooze", style: .default) { _ in   //8a. create our snoozeAction
            guard let textField = snoozeTextField,
               let text = textField.text, !text.isEmpty else { return }
            
            if let time = TimeInterval(text) {
                self.myTimer.startTimer(time*60)
                self.setView()
            }
        }
        
        print(alert.textFields?.first?.placeholder ?? "")  //setting placeholder text
        
        alert.addAction(dismissAction)                   //5a. add dismiss alert action
        alert.addAction(snoozeAction)                    //10a. implement snooze action
        
        present(alert, animated: true, completion: nil)  //3a. present
    }
    
    //MARK: Notification
    
    func scheduleLocalNotification() {                  //4n. set schedule func
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "Wake up!"
        notificationContent.body = "Time to get up"
        
        guard let timeRemaining = myTimer.timeRemaining else { return }   //unwrap timeRemaining
        let fireDate = Date(timeInterval: timeRemaining, since: Date())   //fire at current Date from timeRemaining
        let dateComponents = Calendar.current.dateComponents([.minute, .second], from: fireDate) //set our timing based on current calendar and min/sec from our fireDate
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false) //create dateTrigger for our request below...pull in UNCal, set repeats to false
        let request = UNNotificationRequest(identifier: userNotificationIdentifier, content: notificationContent, trigger: dateTrigger)  //create our request 
        
        UNUserNotificationCenter.current().add(request) { (error) in             //5n. add our notif w/ error msg
            if let error = error {
                print("Unable to add notification. \(error.localizedDescription)")
            }
        }
    }
    
    func canelLocalNotification() {                //3n. add fileprivate identifier ""  to UNUserNotifCenter
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [userNotificationIdentifier])
    }
}

extension TimerViewController: TimerDelegate {        //3d. conform VC to delegate properties to update UI
    
    func timerSecondTicked() {
        updateTimerLabel()
    }
    
    func timerStopped() {
        setView()
        myTimer.timer?.invalidate()
    }
    
    func timerCompleted() {
        setUpAlertController()                     //7a. add alert when timer is completed
        setView()
    }
}

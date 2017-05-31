//
//  AlarmDetailTableViewController.swift
//  AlarmApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, AlarmScheduler {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    //MARK: Properties
    
    var alarm: Alarm? {
        didSet {
            if isViewLoaded {
                updateViews() 
            }
        }
    }
    
    //MARK: IB Properties
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alarmTitle: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    
    //MARK: Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = alarmTitle.text,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return }
        let timeIntervalSinceMidnight = datePicker.date.timeIntervalSince(thisMorningAtMidnight)
        if let alarm = alarm {
            AlarmController.sharedController.updateAlarm(alarm: alarm, fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            cancelUserNotifications(for: alarm)
            scheduleUserNotifications(for: alarm)
        } else {
            let alarm = AlarmController.sharedController.addAlarm(fireTimeFromMidnight: timeIntervalSinceMidnight, name: title)
            self.alarm = alarm
            scheduleUserNotifications(for: alarm)
        }
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func enableButtonTapped(_ sender: Any) {
        guard let alarm = alarm else { return }
        AlarmController.sharedController.toggleEnabled(for: alarm)
        
        if alarm.enabled {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        
        updateViews()
        
    }
    
    
    
    //MARK: Private
    
    private func updateViews() {
        guard let alarm = alarm,
            let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight,
            isViewLoaded else {
                enableButton.isHidden = true
                return
        }
        
        datePicker.setDate(Date(timeInterval: alarm.fireTimeFromMidnight, since: thisMorningAtMidnight), animated: false)
        alarmTitle.text = alarm.name
        
        enableButton.isHidden = false
        if alarm.enabled {
            enableButton.setTitle("Disable", for: UIControlState())
            enableButton.setTitleColor(.white, for: UIControlState())
            enableButton.backgroundColor = .red
        } else {
            enableButton.setTitle("Enable", for: UIControlState())
            enableButton.setTitleColor(.blue, for: UIControlState())
            enableButton.backgroundColor = .gray
        }
        
        self.title = alarm.name
        
    }
}

//
//  AlarmListTableViewController.swift
//  AlarmApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController, SwitchTableViewCellDelegate, AlarmScheduler {  //7. Adopt delegate protocol
    
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    
    // MARK: - TableViewDataSource/Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AlarmController.sharedController.alarms.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell 
        
        let alarm = AlarmController.sharedController.alarms[indexPath.row]  //access indexPath
        cell?.nameLabel?.text = alarm.name
        cell?.timeLabel?.text = alarm.fireTimeAsString
        cell?.alarmSwitch.isOn = alarm.enabled
        
        return cell ?? UITableViewCell()
    }
    
    
    // Slide to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let ac = AlarmController.sharedController
            let alarm = ac.alarms[indexPath.row]
            ac.deleteAlarm(alarm: alarm)
            
            cancelUserNotifications(for: alarm)                     
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: SwitchTableViewCellDelegate
    
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell) {                  //8. Implement toggle alarm func
        guard let alarm = cell.alarm else { return }
        AlarmController.sharedController.toggleEnabled(for: alarm) 
        
        if alarm.enabled {                                                          //Add schedule+cancel to switch
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
        
        tableView.reloadData()                                               //9. reload tableView
    }
    
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlarmDetail" {
            guard let detailVC = segue.destination as? AlarmDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else { return }
            detailVC.alarm = AlarmController.sharedController.alarms[indexPath.row]
        }
    }
}

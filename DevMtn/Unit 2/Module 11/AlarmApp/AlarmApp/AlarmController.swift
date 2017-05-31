//
//  AlarmController.swift
//  AlarmApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import UserNotifications

class AlarmController {
    
    static var sharedController = AlarmController()
    
    init() {
        loadFromPersistentStorage()
    }
    
    func addAlarm(fireTimeFromMidnight: TimeInterval, name: String) -> Alarm {
        let alarm = Alarm(fireTimeFromMidnight: fireTimeFromMidnight, name: name)
        alarms.append(alarm)
        saveToPersistentStorage()
        return alarm
    }
    
    func updateAlarm(alarm: Alarm, fireTimeFromMidnight: TimeInterval, name: String) {
        alarm.fireTimeFromMidnight = fireTimeFromMidnight
        alarm.name = name
        saveToPersistentStorage()
    }
    
    func deleteAlarm(alarm: Alarm) {
        guard let alarmIndex = alarms.index(of: alarm) else { return }
        alarms.remove(at: alarmIndex)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(for alarm: Alarm) {                                            //6. Create func to check if alarm toggled
        alarm.enabled = !alarm.enabled
        saveToPersistentStorage()
        
    }
    
    //MARK: Load(NSKeyedUnarchiver) / Save(NSKeyedArchiver)
    
    private func saveToPersistentStorage() {
        guard let filepath = type(of: self).persistentAlarmsFilePath else { return }  //unwrap alarm files, set filepath
        NSKeyedArchiver.archiveRootObject(self.alarms, toFile: filepath)  //save current [Alarm] to filepath thru NSKeyedArchiver
    }
    
    private func loadFromPersistentStorage() {
        guard let filepath = type(of: self).persistentAlarmsFilePath else { return }  //unwrap alarm files, set filepath
        guard let alarms = NSKeyedUnarchiver.unarchiveObject(withFile: filepath) as? [Alarm] else { return }
        self.alarms = alarms  //access data w/ filepath and unwrap optional results from [Alarm]
    }
    
    
    //MARK: PersistentAlarmsFilePath - return path to alarms file in plist -- needed for Load/Save
    
    static private var persistentAlarmsFilePath: String? {
        let directories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        guard let documentsDirectory = directories.first as NSString? else { return nil }
        return documentsDirectory.appendingPathComponent("Alarms.plist")
    }
    
    //MARK: Properties
    var alarms: [Alarm] = [] 

}

//MARK: AlarmScheduler

protocol AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
    
}

extension AlarmScheduler {
    
    func scheduleUserNotifications(for alarm: Alarm) {
        
        let notificationConent = UNMutableNotificationContent()
        notificationConent.title = "Time's up!"
        notificationConent.body = "Your alarm \(alarm.name) is done"
        
        guard let fireDate = alarm.fireDate else { return }
        let triggerDate = Calendar.current.dateComponents([.hour, .minute, .second], from: fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true) 
        
        let request = UNNotificationRequest(identifier: alarm.uuid, content: notificationConent, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Unable to add notification request, \(error.localizedDescription)")
            }
        }
    }
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}


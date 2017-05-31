//
//  Alarm.swift
//  AlarmApp
//
//  Created by handje on 4/3/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation

class Alarm: NSObject, NSCoding {
    
    private let FireTimeFromMidnightKey = "fireTimeFromMidnight"
    private let NameKey = "name"
    private let EnabledKey = "enabled"
    private let UUIDKey = "UUID"
    
    init(fireTimeFromMidnight: TimeInterval, name: String, enabled: Bool = true, uuid: String = UUID().uuidString) {
        
        self.fireTimeFromMidnight = fireTimeFromMidnight
        self.name = name
        self.enabled = enabled
        self.uuid = uuid 
    }

    //MARK: NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: NameKey) as? String,
            let uuid = aDecoder.decodeObject(forKey: UUIDKey) as? String else { return nil }
        
        self.fireTimeFromMidnight = TimeInterval(aDecoder.decodeDouble(forKey: FireTimeFromMidnightKey))
        self.name = name
        self.enabled = aDecoder.decodeBool(forKey: EnabledKey)
        self.uuid = uuid
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(fireTimeFromMidnight, forKey: FireTimeFromMidnightKey)
        aCoder.encode(name, forKey: NameKey)
        aCoder.encode(enabled, forKey: EnabledKey)
        aCoder.encode(uuid, forKey: UUIDKey)
    }
    
    //MARK: Properties
    
    var fireTimeFromMidnight: TimeInterval
    var name: String
    var enabled: Bool
    let uuid: String
    
    var fireDate: Date? {
        guard let thisMorningAtMidnight = DateHelper.thisMorningAtMidnight else { return nil }
        let fireTimeInMinutes = Int(fireTimeFromMidnight / 60)
        let fireTimeInSeconds = TimeInterval(fireTimeInMinutes * 60)
        let fireDateFromThisMorning = Date(timeInterval: fireTimeInSeconds, since: thisMorningAtMidnight)
        return fireDateFromThisMorning
    }
    
    var fireTimeAsString: String {
        let fireTimeFromMidnight = Int(self.fireTimeFromMidnight)
        var hours = fireTimeFromMidnight/60/60
        let minutes = (fireTimeFromMidnight - (hours*60*60))/60
        if hours >= 13 {
            return String(format: "%2d:%02d PM", arguments: [hours - 12, minutes])
        } else if hours >= 12 {
            return String(format: "%2d:%02d PM", arguments: [hours, minutes])
        } else {
            if hours == 0 {
                hours = 12
            }
            return String(format: "%2d:%02d AM", arguments: [hours, minutes])
        }
    }
}

func ==(lhs: Alarm, rhs: Alarm) -> Bool {
    if lhs.fireTimeFromMidnight != rhs.fireTimeFromMidnight { return false }
    if lhs.name != rhs.name { return false }
    if lhs.enabled != rhs.enabled { return false }
    if lhs.uuid != rhs.uuid { return false }
    
    return true 
}

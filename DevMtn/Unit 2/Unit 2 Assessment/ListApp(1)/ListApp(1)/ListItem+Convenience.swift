//
//  ListItem+Convenience.swift
//  ListApp(1)
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension ListItem {
     
    @discardableResult convenience init(name: String, isComplete: Bool, dueDate: Date, notes: String, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.isComplete = isComplete
        self.dueDate = dueDate as NSDate
        self.notes = notes 
    } 
}

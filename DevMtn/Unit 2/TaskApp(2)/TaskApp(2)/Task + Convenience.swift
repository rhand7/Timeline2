//
//  Task + Convenience.swift
//  TaskApp(2)
//
//  Created by handje on 5/31/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, dueDate: Date, notes: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        self.name = name
        self.dueDate = dueDate as NSDate
        self.notes = notes
        self.isComplete = isComplete
    }
}

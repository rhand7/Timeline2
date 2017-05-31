//
//  Task+Conveniece.swift
//  TaskApp
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    convenience init(name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.notes = notes
        self.due = due as NSDate?
        self.isComplete = false 
    }
}

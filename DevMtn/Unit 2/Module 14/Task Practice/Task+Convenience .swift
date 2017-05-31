//
//  Task+Convenience .swift
//  Task Practice
//
//  Created by handje on 4/6/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Task {
    
    @discardableResult convenience init(name: String, notes: String, due: Date, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)  
        
        self.name = name
        self.due = due as NSDate
        self.notes = notes
        self.isComplete = isComplete
    }
}

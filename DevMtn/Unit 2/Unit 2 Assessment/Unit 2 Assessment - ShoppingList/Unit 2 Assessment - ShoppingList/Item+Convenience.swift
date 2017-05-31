//
//  Item+Convenience.swift
//  Unit 2 Assessment - ShoppingList
//
//  Created by handje on 4/7/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    @discardableResult convenience init(name: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.isComplete = isComplete
    }
    
}

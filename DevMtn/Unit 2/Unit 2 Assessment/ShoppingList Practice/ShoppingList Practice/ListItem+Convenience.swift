//
//  ListItem+Convenience.swift
//  ShoppingList Practice
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension ListItem {
    
    @discardableResult convenience init(name: String, isComplete: Bool, context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.isComplete = isComplete
    } 
    
}

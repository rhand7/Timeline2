//
//  CoreDataStack.swift
//  TaskApp
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        
        let TaskApp = Bundle.main.object(forInfoDictionaryKey: (kCFBundleNameKey as String)) as! String
        
        let container = NSPersistentContainer(name: TaskApp)
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}

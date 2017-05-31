//
//  CoreDataStack.swift
//  PlaylistNSUserDefaults
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let container: NSPersistentContainer = {             //lazy var = { ... }() - not captured until var is called 
    
        let container = NSPersistentContainer(name: "Playlist") //"" must match .xcdatamodel
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext 
    }
    
}

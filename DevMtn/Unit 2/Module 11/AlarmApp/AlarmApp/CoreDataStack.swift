//
//  CoreDataStack.swift
//  AlarmApp
//
//  Created by handje on 4/4/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Journal")
        container.loadPersistentStores() { (storeDescription, error) in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        return container 
    }()
    
}




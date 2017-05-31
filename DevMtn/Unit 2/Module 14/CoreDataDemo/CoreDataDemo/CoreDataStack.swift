//
//  CoreDataStack.swift
//  CoreDataDemo
//
//  Created by Michael Huber Jr on 4/6/17.
//  Copyright © 2017 operation thirteenOne. All rights reserved.
//

import Foundation
import CoreData

enum CoreDataStack {

    static var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataDemo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                // Do some error handling
            }
        })

        return container
    }()

    static var context: NSManagedObjectContext {
        return container.viewContext
    }

}

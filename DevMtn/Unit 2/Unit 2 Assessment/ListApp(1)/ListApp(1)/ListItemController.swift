//
//  ListItemController.swift
//  ListApp(1)
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

class ListItemController {
    
    static let sharedController = ListItemController()
    
    var listItems: [ListItem] {
        return fetchRequest()
    }
    
    
    //MARK: CRUD
    
    func addListItemWith(name: String, dueDate: Date, notes: String) {
        let _ = ListItem(name: name, isComplete: false, dueDate: dueDate, notes: notes) 
        saveToPersistentStore()
    }
    
    func deleteListItem(listItem: ListItem) {
        let moc = CoreDataStack.context
        moc.delete(listItem)
    }
    
    func updateListItem(listItem: ListItem, name: String, isComplete: Bool, dueDate: Date?, notes: String) {
        listItem.name = name
        listItem.isComplete = isComplete
        listItem.dueDate = dueDate as NSDate?
        listItem.notes = notes
        saveToPersistentStore()
    }
    
    func toggleIsComplete(listItem: ListItem) {
        listItem.isComplete = !listItem.isComplete
        saveToPersistentStore()
    }
    
    //MARK: saveToPersistentStore
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            NSLog("Error trying to save to PersistentStore")
        }
    }
    
    //MARK: fetchRequest
    
    func fetchRequest() -> [ListItem] {
        let fetchRequest: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks from persistent store")
            return []
        }
    }
}

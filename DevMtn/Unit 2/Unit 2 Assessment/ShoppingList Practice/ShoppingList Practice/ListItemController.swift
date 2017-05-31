//
//  ListItemController.swift
//  ShoppingList Practice
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
    
    //CRUD 
    
    func addListItem(name: String, isComplete: Bool) {
        let _ = ListItem(name: name, isComplete: isComplete)
        saveToPeristentStore()
    }
    
    func delete(listItem: ListItem) {
    let moc = CoreDataStack.context
        moc.delete(listItem)
    }
    
    func update(listItem: ListItem, name: String, isComplete: Bool) {
        listItem.name = name
        listItem.isComplete = isComplete
        saveToPeristentStore()
    }
    
    func toggleIsComplete(listItem: ListItem) {
        listItem.isComplete = !listItem.isComplete
        saveToPeristentStore() 
    }
    
    //saveToPersistentStore
    
    func saveToPeristentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            NSLog("Error saving to peristent store")
        }
    }
    
    //fetchRequest 
    
    func fetchRequest() -> [ListItem] {
        let fetchRequest: NSFetchRequest<ListItem> = ListItem.fetchRequest()
        
        do{
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks from peristent store")
            return []
        }
    }
}

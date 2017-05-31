//
//  ItemController.swift
//  Unit 2 Assessment - ShoppingList
//
//  Created by handje on 4/7/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static let sharedController = ItemController()                                  //Singleton - bridge Ctrl to View 
    
    var items: [Item] {
        return fetchItems() 
    }
    
    //MARK: CRUD
    
    func addItemWith(name: String, isComplete: Bool) {
        let _ = Item(name: name, isComplete: false)
        saveToPersistentStore()
    }
    
    func delete(item: Item) {
    let moc = CoreDataStack.context
        moc.delete(item)
    }
    
    func update(item: Item, name: String, isComplete: Bool) {
        item.name = name
        item.isComplete = isComplete
        saveToPersistentStore()
        
    }
    
    func toggleIsCompleteFor(item: Item) {
        item.isComplete = !item.isComplete
        saveToPersistentStore()
    }
    
    
    //MARK: saveToPersistentStore
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch {
            NSLog("Error saving Item to managed object context")
        }
    }

    
    //MARK: fetchRequest
    
    func fetchItems() -> [Item] {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            NSLog("Error fetching tasks from persistent store")
            return []
        }
    }

}

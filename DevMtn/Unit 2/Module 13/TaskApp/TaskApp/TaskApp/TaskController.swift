//
//  TaskController.swift
//  TaskApp
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    
    static var shared = TaskController()
    
    init() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        let completedSortDescriptor = NSSortDescriptor(key: "isComplete", ascending: true)
        let dueSortDescriptor = NSSortDescriptor(key: "due", ascending: true)
        request.sortDescriptor = [completedSortDescriptor, dueSortDescriptor]
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request as! NSFetchRequest<_>,
                                                                   managedObjectContext: CoreDataStack.context,
                                                                   sectionNameKeyPath: "isComplete",
                                                                   cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
        } catch {
            NSLog("Error performing the fetch request: \(error)") 
        }
    }
    
    //MARK: Public -- CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
        let _ = Task(name: name, notes: notes, due: due)
        saveToPersistentStore()
        
        
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due as NSDate?
        saveToPersistentStore()
        
        
    }
    
    func remove(task: Task) {
        task.managedObjectContext?.delete(task)
        saveToPersistentStore()
        
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()  
    }
    
    //MARK: saveToPersistentStore()
    
    private func saveToPersistentStore() {
        let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch {
            print("There was a problem saving to the persistent store: \(error)")
        }
    }
    
    //MARK: fetch
    

    //MARK: Properties
    
    var tasks: [Task] = []
    
    let fetchedResultsController: NSFetchedResultsController<Task>
}


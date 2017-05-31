//
//  TaskController.swift
//  Task Practice
//
//  Created by handje on 4/6/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

class TaskController {
    
    static let sharedController = TaskController()                 //bridge from Controller to View
    
    var tasks: [Task] {                                            //var tasks is a computed property - has a func 
        return fetchTasks()
    }
    
    // CRUD
    
    func createTaskWith(name: String, notes: String, due: Date) {
        let _ = Task(name: name, notes: notes, due: due, isComplete: false)
        saveToPersistentStore()
    }
    
    func delete(task: Task) {
     let moc = CoreDataStack.context
        moc.delete(task)
    }
    
    func update(task: Task, name: String, notes: String?, due: Date?, isComplete: Bool) {
        
        task.name = name
        task.notes = notes
        task.due = due as NSDate?
        task.isComplete = isComplete
        saveToPersistentStore()
    }
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do{
            try moc.save()
        } catch {
            NSLog("Error saving Tasks to managed object context.")
        }
    }
    
    func fetchTasks() -> [Task] {
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try CoreDataStack.context.fetch(fetchRequest)
        } catch {
            NSLog("error fetching tasks from persistent store")
            return[]
        }
    }
}






















//
//  PersonController.swift
//  CoreDataDemo
//
//  Created by Michael Huber Jr on 4/6/17.
//  Copyright © 2017 operation thirteenOne. All rights reserved.
//

import Foundation
import CoreData

class PersonController {

    static let shared = PersonController()

    var people: [Person] {
        let request: NSFetchRequest<Person> = Person.fetchRequest()

        return (try? CoreDataStack.context.fetch(request)) ?? []
    }

    func create(name: String) {
        let _ = Person(name: name)
        saveToPersistence()
    }

    func saveToPersistence() {
        let moc = CoreDataStack.context

        do {
            try moc.save()
        } catch {
            print("Error")
        }
    }

}

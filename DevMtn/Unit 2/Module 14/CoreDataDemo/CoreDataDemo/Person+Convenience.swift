//
//  Person+Convenience.swift
//  CoreDataDemo
//
//  Created by Michael Huber Jr on 4/6/17.
//  Copyright © 2017 operation thirteenOne. All rights reserved.
//

import Foundation
import CoreData

extension Person {

    convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {

        self.init(context: context)
        self.name = name

    }

}

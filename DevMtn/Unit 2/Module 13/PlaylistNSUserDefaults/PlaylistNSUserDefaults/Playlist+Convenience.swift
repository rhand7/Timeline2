//
//  Playlist+Convenience.swift
//  PlaylistNSUserDefaults
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation
import CoreData

extension Playlist {
    
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name 
    }
    
}



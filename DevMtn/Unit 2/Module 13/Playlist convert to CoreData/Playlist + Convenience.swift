//
//  Playlist + Convenience.swift
//  Playlist
//
//  Created by handje on 5/31/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Playlist {
    
    convenience init(name: String,
                     context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
    }
}

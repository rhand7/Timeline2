//
//  Song + Convenience.swift
//  Playlist
//
//  Created by handje on 5/31/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    
    convenience init (name: String,
                      artist: String,
                      playlist: Playlist, 
                      context: NSManagedObjectContext = CoreDataStack.context) {
        
        self.init(context: context)
        
        self.name = name
        self.artist = artist
        self.playlist = playlist
        
    }
}

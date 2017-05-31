//
//  Song+Convenience.swift
//  PlaylistNSUserDefaults
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import Foundation
import CoreData

extension Song {
    
    @discardableResult convenience init(name: String,
                                        artist: String,
                                        playlist: Playlist,
                                        context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        
        self.name = name
        self.artist = artist
        self.playlist = playlist
    }
}

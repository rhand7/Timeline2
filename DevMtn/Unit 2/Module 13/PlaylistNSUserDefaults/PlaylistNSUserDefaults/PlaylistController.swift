//
//  PlaylistController.swift
//  Playlist
//
//  Created by James Pacheco on 5/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    fileprivate static let PlaylistsKey = "playlists"
    
    static let sharedController = PlaylistController()
    
    func create(playlistWithName name: String) {
        let _ = Playlist(name: name)
    }
    
    func delete(playlist: Playlist) {
        if let moc = playlist.managedObjectContext {
            moc.delete(playlist)
            saveToPersistentStore()
        }
    }
	
	// MARK: Persistence
	
    func saveToPersistentStore() {
		let moc = CoreDataStack.context
        
        do {
            try moc.save()
        } catch let error {
            print("There was a problem saving to the persistent store: \(error)")
        }
    }
    
	
	// MARK: Properties 
	
    var playlists: [Playlist] {
        let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
}

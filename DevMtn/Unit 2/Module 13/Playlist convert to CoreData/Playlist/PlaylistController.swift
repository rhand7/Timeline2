//
//  PlaylistController.swift
//  Playlist
//
//  Created by handje on 3/29/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation
import CoreData

class PlaylistController {
    
    static let shared = PlaylistController()
    
    // MARK: Properties
    
    var playlists: [Playlist] {
        
        let request: NSFetchRequest<Playlist> = Playlist.fetchRequest()
        
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //CRUD
    
    func add(playlistWithName name: String) {
        
        _ = Playlist(name: name) //creates new playlist
        
        save() //sends to persistent store
        
    }
    
//    func remove(song: Song, fromPlaylist playlist: Playlist) {
//        guard let index = playlist.songs.index(of: song) else {
//            return 
//        }
//        
//        playlist.songs.remove(at: index)
//        save()
//    }
    
    func delete(playlist: Playlist) {
//        guard let index = playlists.index(of: playlist) else {
//            return
//        }
//        playlists.remove(at: index)
//        save()
    }
    
    //MARK: Persistence
    
    func save() {
        
        let moc = CoreDataStack.context
        
            do {
                try moc.save()
            } catch {
                print("there was an error saving to persitent store: \(error.localizedDescription)")
        }
    }
}

//
//  SongController.swift
//  Playlist
//
//  Created by James Pacheco on 5/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class SongController {
    
	static func create(songWithName name: String, artist: String, playlist: Playlist) {
		let _ = Song(name: name, artist: artist, playlist: playlist)
        PlaylistController.sharedController.saveToPersistentStore()
	}
    
    static func delete(song: Song) {
        if let moc = song.managedObjectContext {
            moc.delete(song) 
            PlaylistController.sharedController.saveToPersistentStore()
        }
    }
}

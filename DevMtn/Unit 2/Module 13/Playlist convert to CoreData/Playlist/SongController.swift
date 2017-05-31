//
//  SongController.swift
//  Playlist
//
//  Created by handje on 3/29/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import Foundation

class SongController {
    
    static func create(songWithName name: String, artist: String, playlist: Playlist) {
        
        _ = Song(name: name, artist: artist, playlist: playlist) //creating a new (instance) song
        
        PlaylistController.shared.save() 
    }
}

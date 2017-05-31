//
//  SongTableViewController.swift
//  Playlist
//
//  Created by handje on 3/29/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class SongTableViewController: UITableViewController {

    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let playlist = playlist,
            let songName = songName.text,
            let artistName = artistName.text,
            !songName.isEmpty,
            !artistName.isEmpty
        else { return }
        
        SongController.create(songWithName: songName, artist: artistName, playlist: playlist)
        
        self.songName.text = ""
        self.artistName.text = ""
        
        tableView.reloadData() 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = playlist?.name
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath)

        guard let song = playlist?.songs?[indexPath.row] as? Song else { return cell } 
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist

        return cell
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete {
//            guard let playlist = playlist else { return }
//            let song = playlist.songs[indexPath.row]
//            PlaylistController.shared.remove(song: song, fromPlaylist: playlist)
//            tableView.deleteRows(at: [indexPath], with: .fade) //array of indexPath used to delete more than 1 thing at once
//        }
//    }
    
    var playlist: Playlist?
 

    @IBOutlet weak var songName: UITextField!
    @IBOutlet weak var artistName: UITextField!
    

}

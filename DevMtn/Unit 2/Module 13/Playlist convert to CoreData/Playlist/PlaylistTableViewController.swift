//
//  PlaylistTableViewController.swift
//  Playlist
//
//  Created by handje on 3/29/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {

    @IBAction func addButtonTapped(_ sender: Any) {
        guard let playlistName = nameField.text, !playlistName.isEmpty else { return }
        
        PlaylistController.shared.add(playlistWithName: playlistName)
        nameField.text = ""
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        PlaylistController.shared.add(playlistWithName: "Cool Playlist")
//        PlaylistController.shared.add(playlistWithName: "Awesome Playlist")
//        PlaylistController.shared.add(playlistWithName: "Rad Playist")
//        
//        let playlist1 = PlaylistController.shared.playlists[0]
//        let playlist2 = PlaylistController.shared.playlists[1]
//        let playlist3 = PlaylistController.shared.playlists[2]
//        
//        SongController.create(songWithName: "Test Song 1", artist: "Test Artist 1", playlist: playlist1)
//        SongController.create(songWithName: "Test Song2", artist: "Test Artist 2", playlist: playlist1)
//        SongController.create(songWithName: "Test Song3", artist: "Test Artist 3", playlist: playlist2)
//        SongController.create(songWithName: "Test Song4", artist: "Test Artist 4", playlist: playlist3)
    }
    
    override func viewWillAppear(_ animated: Bool) {  //Updates Playlist song count after deleting songs 
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PlaylistController.shared.playlists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        let songs = playlist.songs ?? []
        
        cell.textLabel?.text = playlist.name
        cell.detailTextLabel?.text = "\(songs.count)" 
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.delete(playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PlaylistDetailSegue" {
            let songVC = segue.destination as? SongTableViewController //destination is UIVC need to cast to SongTABLEVC
            
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            songVC?.playlist = playlist   //since as? that makes songVC optional, we have to unwrap 
            songVC?.title = title 
        }
    }

    @IBOutlet weak var nameField: UITextField!
    
}




















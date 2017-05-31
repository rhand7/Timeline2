//
//  PlaylistTableViewController.swift
//  Playlist
//
//  Created by James Pacheco on 5/4/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class PlaylistTableViewController: UITableViewController {
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	@IBAction func addButtonTapped(_ sender: AnyObject) {
		guard let playlistName = playlistTextField.text, !playlistName.isEmpty else {return}
		PlaylistController.sharedController.create(playlistWithName: playlistName)
		playlistTextField.text = ""
		tableView.reloadData()
	}
	
	// MARK: UITableViewDataSource/Delegate
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return PlaylistController.sharedController.playlists.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
		
		let playlist = PlaylistController.sharedController.playlists[indexPath.row]
        guard let songs = playlist.songs else { return UITableViewCell() }
		cell.textLabel?.text = playlist.name
		cell.detailTextLabel?.text = "\(songs.count) songs"
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Playlists"
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			let playlist = PlaylistController.sharedController.playlists[indexPath.row]
			PlaylistController.sharedController.delete(playlist: playlist)
			tableView.deleteRows(at: [indexPath], with: .fade)
		}
	}
	
	// MARK: Navigation
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "toPlaylistDetail",
			let indexPath = tableView.indexPathForSelectedRow {
			let playlist = PlaylistController.sharedController.playlists[indexPath.row]
			let songVC = segue.destination as? SongTableViewController
			songVC?.playlist = playlist
		}
	}
	
	// MARK: Properties
	
	@IBOutlet weak var playlistTextField: UITextField!
}

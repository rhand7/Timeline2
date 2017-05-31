import UIKit
import CoreData

//NSFetchedResutlsControllerDelegate

func controller(_ controller: NSFetchRequestController<NSFetchRequestResult>,
                didChange anObject: Any,
                at indexPath: IndexPath,
                for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    switch type {
    case .delete:
        guard let indexPath = indexPath else { return }
        tableView.deleteRows(at: [indexPath], with: .fade)
    case .insert:
        guard  let newIndexPath = newIndexPath else { return }
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    case .move:
        guard  let indexPath = indexPath,
            let newIndexPath = newIndexPath else { return }
        tableView.moveRow(at: indexPath, to: newIndexPath)
    case .update:
        guard let indexPath = indexPath else { return }
        tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        }
    }
}


//update data source methods

override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return NSFetchedResultsController.fetchedObjects?.count ?? 0
}

override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell - tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
    
    guard let playlists = NSFetchedResultsController.fetchedObjects ?? []
    let playlist = playlists[indexPath.row]
    cell.textLabel?.text = playlist.name
    cell.detailTextLabel?.text = "\(playlist.songs!.count) songs"
    
    return cell
}
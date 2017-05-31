//
//  ViewController.swift
//  AlertController
//
//  Created by handje on 4/6/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var items: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var alertTextField: UITextField?
        let alertController = UIAlertController(title: "Add Item", message: "Add an Item...", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            alertTextField = textField
        }
        
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
        let addAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = alertTextField?.text, !text.isEmpty else { return }
            self.items.append(text)
            self.tableView.reloadData()
        }
        
        alertController.addAction(dismissAction)
        alertController.addAction(addAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    
}



//
//  ListItemTableViewController.swift
//  ShoppingList Practice
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ListItemTableViewController: UITableViewController, CheckBoxTableViewCellDelegate {

    //MARK: Properties
    
    var listItems: [ListItem] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    
    // MARK: - TableViewDataSource/Delegate

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }

    //#RowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListItemController.sharedController.listItems.count
    }

    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as? CheckBoxTableViewCell else { return UITableViewCell() }
        
        let listItem = ListItemController.sharedController.listItems[indexPath.row]
        
        cell.delegate = self
        cell.listItem = listItem
        cell.updateList(listItem: listItem)

        return cell
    }

    // slide to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let lic = ListItemController.sharedController
            let listItem = lic.listItems[indexPath.row]
            lic.delete(listItem: listItem)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //MARK: TableViewCellDelegate
    
    func checkboxCellButtonTapped(sender: CheckBoxTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let listItem = ListItemController.sharedController.listItems[indexPath.row]
        ListItemController.sharedController.toggleIsComplete(listItem: listItem)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    //MARK: IB Action
    @IBAction func addItemButtonTapped(_ sender: Any) {
        setUpAlertController()
    }
    
    //MARK: AlertController
    
    func setUpAlertController () {
        
        //alert w/ textField
        let alert = UIAlertController(title: "Add Item", message: "Add an item to your list", preferredStyle: .alert)
        var itemTextField = UITextField()
        
        alert.addTextField { (textField) in
            itemTextField = textField
            itemTextField.placeholder = "Enter an item to your list..."
        }
        
        //add button
        let addItem = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = itemTextField.text, !text.isEmpty else { return }
            ListItemController.sharedController.addListItem(name: text, isComplete: true)
            self.tableView.reloadData()
        }
        
        //cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .default) { _ in
        }
        
        alert.addAction(addItem)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}















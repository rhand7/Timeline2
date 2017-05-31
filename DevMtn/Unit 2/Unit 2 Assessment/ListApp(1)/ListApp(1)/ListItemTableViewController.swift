//
//  ListItemTableViewController.swift
//  ListApp(1)
//
//  Created by handje on 4/8/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ListItemTableViewController: UITableViewController, CheckBoxButtonTableViewCellDelegate {
    
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
    
    // MARK: - TableViewDataSource
    
    //    override func numberOfSections(in tableView: UITableView) -> Int {
    //        return 0
    //    }
    
    //#RowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListItemController.sharedController.listItems.count
    }
    
    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listItemCell", for: indexPath) as? CheckBoxButtonTableViewCell else { return UITableViewCell() }
        
        let listItem = ListItemController.sharedController.listItems[indexPath.row]
        
        cell.delegate = self
        cell.listItem = listItem
        cell.updateList(listItem: listItem)
        
        return cell
    }
    
    
    //slide to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let lIC = ListItemController.sharedController
            let listItem = lIC.listItems[indexPath.row]
            lIC.deleteListItem(listItem: listItem)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //TableViewCellDelegate - update checkbox via delegate
    
    func checkBoxCellButtonTapped(sender: CheckBoxButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let listItem = ListItemController.sharedController.listItems[indexPath.row]
        ListItemController.sharedController.toggleIsComplete(listItem: listItem)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    //MARK: IB Actions
    
    @IBAction func addItemButtonTapped(_ sender: Any) {
        setUpAlertController()
    }
    
    
    //MARK: AlertController
    
    func setUpAlertController() {
        
        //add alert w/ textField
        let alert = UIAlertController(title: "Add List Item", message: "Add a new item to your list", preferredStyle: .alert)
        
        var itemTextField = UITextField()
        
        alert.addTextField { (textField) in
            itemTextField = textField
            itemTextField.placeholder = "Enter your new item here..."
        }
        
        //add button
        let addItem = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = itemTextField.text, !text.isEmpty else { return }
            ListItemController.sharedController.addListItemWith(name: text, isComplete: Bool, notes: text, dueDate: Date)
            self.tableView.reloadData() 
        }
        
        //cancel button
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        
        alert.addAction(addItem)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}

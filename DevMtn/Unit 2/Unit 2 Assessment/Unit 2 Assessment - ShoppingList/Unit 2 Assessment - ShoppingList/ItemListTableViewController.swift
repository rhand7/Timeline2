//
//  ItemListTableViewController.swift
//  Unit 2 Assessment - ShoppingList
//
//  Created by handje on 4/7/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class ItemListTableViewController: UITableViewController, ButtonTableViewCellDelegate {  //3. conforms to BTbVCellDelegate
    
    var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    
    // MARK: - TableViewDataSource/Delegate
    
    //#RowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemController.sharedController.items.count
    }
    
    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ButtonTableViewCell
            else { return UITableViewCell() }                                         //6. add delegate and update cell
        
        let item = ItemController.sharedController.items[indexPath.row]
        
        cell.delegate = self
        cell.item = item                                        //gets item from BTbVCell
        cell.updateList(listItem: item) 
        
        return cell
    }
    
    
    // slide to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let ic = ItemController.sharedController
            let item = ic.items[indexPath.row]
            ic.delete(item: item) 
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    //ButtonTableViewCellDelegate
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {                       //3. add protocol
        guard let indexPath = tableView.indexPath(for: sender) else { return }       //5. implement cell delegate
        let item = ItemController.sharedController.items[indexPath.row]
        ItemController.sharedController.toggleIsCompleteFor(item: item)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    //MARK: IB Action - Add List Item Button
    
    var item: Item?
    
    @IBAction func addButtonTapped(_ sender: Any) {
        setUpAlertController()
    }
    
    
    //MARK: AlertController
    
    func setUpAlertController () {
        
        let alert = UIAlertController(title: "Add Item", message: "Add an item to your list", preferredStyle: .alert)
        var itemTextField = UITextField()
        
        alert.addTextField { (textField) in
            itemTextField = textField
            itemTextField.placeholder = "List Item"
        }
        
        let addItem = UIAlertAction(title: "Add", style: .default) { _ in
            guard let text = itemTextField.text, !text.isEmpty else { return }
            ItemController.sharedController.addItemWith(name: text, isComplete: true)
            self.tableView.reloadData()
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
        }
        alert.addAction(cancelAction)
        alert.addAction(addItem)
        self.present(alert, animated: true, completion: nil) 
    }
}


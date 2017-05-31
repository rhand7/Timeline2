//
//  TaskListTableViewController.swift
//  Task Practice
//
//  Created by handje on 4/6/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate { 
    
    var tasks: [Task] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        let t1 = Task(name: "Foo", notes: "bar", due: Date(), isComplete: false)
        let t2 = Task(name: "Foo", notes: "bar", due: Date(), isComplete: false)
        let t3 = Task(name: "Foo", notes: "bar", due: Date(), isComplete: false)
        
        self.tasks = [t1, t2, t3]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    // MARK: - TableViewDataSource/Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedController.tasks.count                 //tasks computed prop is our fetched to check with NSPersistentStore
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell else { return UITableViewCell() }
        
        let task = TaskController.sharedController.tasks[indexPath.row]
        
        cell.delegate = self
        cell.task = task
        
        return cell
    }
    
    func buttonCellButtonTapped(sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = self.tasks[indexPath.row]
        TaskController.sharedController.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // slide to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

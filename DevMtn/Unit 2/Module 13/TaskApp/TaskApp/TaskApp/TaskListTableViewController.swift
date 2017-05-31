//
//  TaskTableViewController.swift
//  TaskApp
//
//  Created by handje on 4/6/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - TableViewDataSource/Delegate
    
    //#ofSections
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let sections = TaskController.shared.fetchedResultsController.sections else {return 1}
        return sections.count
    }
    
    //#RowsInSection
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = TaskController.shared.fetchedResultsController.sections else {return 0}
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    //cellForRowAt
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell,
            let task = TaskController.shared.fetchedResultsController.object(at: indexPath) as? Task else { return ButtonTableViewCell()}
        cell.update(withTask: task)
        cell.delegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sectionInfo = TaskController.shared.fetchedResultsController.sections,
            let index = Int(sectionInfo[section].name) else { return nil }
        if index == 0 {
            return "Incomplete Tasks"
        } else {
            return "Complete Tasks"
        }
    }
    
    // slide to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: task)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    //MARK: ButtonTableViewCellDelegate
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowTask" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            
            let task = TaskController.shared.tasks[indexPath.row]
            let detailVC = segue.destination as? TaskDetailTableViewController
            detailVC?.task = task
            detailVC?.dueDateValue = task.due as? Date
        }
        
    }
}

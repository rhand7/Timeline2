//
//  TaskDetailTableViewController.swift
//  TaskApp
//
//  Created by handje on 4/5/17.
//  Copyright © 2017 Rob Hand. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueDateTextField.inputView = dueDatePicker
        updateViews()
        
    }
    
    //MARK: Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        updateTask()
        let _ = navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        let _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueDateTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.nameTextField.resignFirstResponder()
        self.dueDateTextField.resignFirstResponder()
        self.notesTextField.resignFirstResponder()
    }
    
    
    //MARK: Private
    
    private func updateTask() {
        
        guard let name = nameTextField.text else { return }
        let due = dueDateValue
        let notes = notesTextField.text
        
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
    }
    
    private func updateViews() {
        guard let task = task, isViewLoaded else { return }
        
        title = task.name
        nameTextField.text = task.name
        dueDateTextField.text = (task.due as Date?)?.stringValue()
        notesTextField.text = task.notes
        
    }
    
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    var dueDateValue: Date?
    var task: Task? {
        didSet {
            updateViews()
        }
    }
}

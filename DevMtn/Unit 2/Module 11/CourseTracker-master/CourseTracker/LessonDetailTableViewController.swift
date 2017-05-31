//
//  LessonDetailTableViewController.swift
//  CourseTracker
//
//  Created by handje on 4/1/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class LessonDetailTableViewController: UITableViewController, ObjectiveTableViewCellDelegate {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var studentNotesLabel: UILabel!
    
    var lesson: Lesson?                                   //Model Object user taps on lesson we grab that from LC and pass to VC to populate all of its views
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if let lesson = lesson {                        //Unwrapping the optional lesson created above
            
            descriptionLabel.text = lesson.description
            studentNotesLabel.text = lesson.studentNotes
            
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of objectives from Lesson Model Object
        if let lesson = lesson {                                      //lesson is optional so if let
            return lesson.objectives.count
        } else {
            return 0
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "objectiveCell", for: indexPath) as! ObjectiveTableViewCell
        
        cell.delegate = self
        
        if let objective = lesson?.objectives[indexPath.row] {  //if we have an obj, we will set cell's obj textLabel to obj name
            cell.objectiveLabel.text = objective.name
            cell.masterySwitch.isOn = objective.userHasMastered
        } else {
            cell.objectiveLabel.text = ""
            cell.masterySwitch.isOn = false
            
            return cell
        }
    }
    
    
    // MARK: Objective Table View Cell Delegate
    
    func masterySwitchValueChangeOnCell(cell: ObjectiveTableViewCell) {             // change our Models property
        if let indexPath = tableView.indexPath(for: cell), let lesson = lesson {    // grabbing our Model Object (cell) and get our objective (model) from the lesson
            let objective = lesson.objectives[indexPath.row]
            
            objective.userHasMastered = cell.masterySwitch.isOn             //we now have access to the switch through the cell
            //this func is the message that still needs a reciever 
    }



/*
 // Override to support conditional editing of the table view.
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the specified item to be editable.
 return true
 }
 */

/*
 // Override to support editing the table view.
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 if editingStyle == .delete {
 // Delete the row from the data source
 tableView.deleteRows(at: [indexPath], with: .fade)
 } else if editingStyle == .insert {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 // Return false if you do not want the item to be re-orderable.
 return true
 }
 */

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}

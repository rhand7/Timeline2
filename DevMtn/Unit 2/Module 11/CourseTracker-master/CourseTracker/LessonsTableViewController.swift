//
//  LessonsTableViewController.swift
//  CourseTracker
//
//  Created by handje on 4/1/17.
//  Copyright © 2017 DevMountain. All rights reserved.
//

import UIKit

class LessonsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Week \(section + 1)"    //Creating Title Header for Setion
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        let countDouble = Double(LessonController.sharedController.lessons.count)    //allowing for Int div by Double
        let numberDaysInWeekDouble = 5.0
        
        let ceiling = ceil(countDouble / numberDaysInWeekDouble)
        
        let numberOfSections = Int(ceiling)
        
        return numberOfSections 
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        if LessonController.sharedController.lessons.count % 5 == 0 {
//            return 5
//        } else {
//            let lastSection = LessonController.sharedController.lessons.count / 5
//            
//            if lastSection == section {
//                return LessonController.sharedController.lessons.count % 5
//            } else {
//                return 5
//            }
//        }
//    }                
        
        //Determining how many rows are in each section before starting a new section
        
        if LessonController.sharedController.lessons.count % 5 == 0 {
            return LessonController.sharedController.lessons.count % 5
        } else {
            return 5
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lessonCell", for: indexPath) as! LessonTableViewCell
        
        let index = indexPath.section * 5 + indexPath.row            //determining the index to start at
        
        let lesson = LessonController.sharedController.lessons[indexPath.row] //grab lesson data from sharedCont to row
        
        var dateString = "Week \(indexPath.section + 1)\n" //labeling sections 0-4 starting w/ Week 1
        
        switch indexPath.row {
        case 0: dateString = dateString + "Mon"
        case 1: dateString = dateString + "Tues"
        case 2: dateString = dateString + "Wed"
        case 3: dateString = dateString + "Thurs"
        case 4: dateString = dateString + "Fri"
        default: break
        }
        
        cell.dateLabel.text = dateString 
        cell.nameLabel.text = lesson.name
        
        return cell
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

    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "toLessonDetail" {              //1. check identifier
            let lessonDetailTableViewController = segue.destination as! LessonDetailTableViewController //2. prep destVC
            
            if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {//unwrapped indexPath
                let index = indexPath.section * 5 + indexPath.row       //determining index based on #ofSections + rows
                
                let lessonToPass = LessonController.sharedController.lessons[index]      //get Model Obj to pass to destVC
                lessonDetailTableViewController.lesson = lessonToPass     //3. Pass Model Obj to destVC
            
            }
        }
    }


}

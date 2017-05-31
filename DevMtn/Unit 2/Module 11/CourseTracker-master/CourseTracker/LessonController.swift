//
//  CourseController.swift
//  CourseTracker
//
//  Created by Taylor Mott on 2/12/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class LessonController {
    
    
    //CREATE -
    func insertNewCourse() -> Lesson {
        let newCourse = Lesson()
        lessons.append(newCourse)
        return newCourse
    }
    
    //UPDATE - taken care of through pointers
    
    //RETREIVE -
    static let sharedController = LessonController()
    var lessons = [Lesson]()
    
    //DELETE -
    func deleteLesson(_ lessonToDelete: Lesson) -> Bool {
        if lessons.contains(lessonToDelete) {
            if let index = lessons.index(of: lessonToDelete) {
                lessons.remove(at: index)
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
    
    init() {
        
        let jsonFilePath = Bundle.main.path(forResource: "lesson-data", ofType: "json")
        var fileData: Data?
        var lessonJSON: AnyObject?
        
        //Parse JSON File
        guard let filePath = jsonFilePath else { return }
        
        fileData = try? Data(contentsOf: URL(fileURLWithPath: filePath))
        guard let data = fileData else { return }
        
        do {
            try lessonJSON = JSONSerialization.jsonObject(with: data, options: [])
        } catch let error as NSError {
            
            print("ERROR -- Serializing JSON - RETURNING from \(#function) - Error message: \(error.localizedDescription)")
        }
        
        guard let json = lessonJSON as? [[String : AnyObject]] else { return }
        
        for lessonDictionary in json {
            let newCourse = insertNewCourse()
            newCourse.updateWithDictionary(lessonDictionary)
        }
        
    }
    
}

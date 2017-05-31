import UIKit

let IntArray = [ 1,2,3,4,5,6,7,8,9,10]

func tooHighOrLow(array: [Int]) {
    var previous = 0
    
    for value in array {
        var output = ""
        
        if value < 50 {
            output += "Low, "
        } else {
            output += "High, "
        }
        
        if value % 13 == 0 {
            output += "didn't learn this in school"
        }
    }
}

// MARK: Part 2
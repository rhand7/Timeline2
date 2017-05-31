import UIKit

//let currentYear = 2017
//
//struct Person {
//    
//    //MARK: Properties
//    let firstName: String
//    let lastName: String
//    var birthYear: Int
//    
//    var age: Int {
//        get {
//            let age = currentYear - birthYear
//            return age
//        }
//        set(value) {
//            birthYear = currentYear - value
//        }
//    }
//}
//
//let rob = Person(firstName: "Rob", lastName: "Hand", birthYear: 1990)
//print("\(rob.firstName) \(rob.lastName) was born in \(rob.birthYear)")
//print("\(rob.age)")


//MARK: Black Diamond

let date = Date()
let calendar = Calendar.current
let year = calendar.component(.year, from: date)
print(year)

struct Person {

    //MARK: Properties
    let firstName: String
    let lastName: String
    var birthYear: Int

    var age: Int {
        get {
            let age = year - birthYear
            return age
        }
        set(value) {
            birthYear = year - value
        }
    }
}

let rob = Person(firstName: "Rob", lastName: "Hand", birthYear: 1990)
print("\(rob.firstName) \(rob.lastName) was born in \(rob.birthYear)")
print("\(rob.age)")




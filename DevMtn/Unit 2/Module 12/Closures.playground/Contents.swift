//import UIKit
//
//let arrayOfNames = ["nick", "spencer", "ryan"]
//
//let namesUppercased = arrayOfNames.flatMap { (name) -> String in   //sequence protocol
//    name.uppercased()
//}
//
//print(namesUppercased)
//
//let sortedNames = namesUppercased.sorted { (first, second) -> Bool in
//    return first > second
//}
//
//print(sortedNames)
//
//sorted(completion: (String, String) -> Bool) {
// when you pass in the first and second it performs the calc based on the completion method and sorts that returns a result  
//
//
//closure is a func that gets passed into a func 
//
//func do something(string: String) {
//    print("Hello")
//}
//
//doSomething(string: "Hello")
//
//var doit = doSomething
//
//doit("String")
//
//func printSomething(block: (String) -> Void) {
//    block ("World")
//}
//
//printSomething { (name) in
//    print("Hello \(name)")
//}
//
//let alert + UIAlertController(title: "test", preferredStyle: .alert)
//alert.addTextField { (textField) in
//    textField.placeholder = "Test"
//}
//

import UIKit

func performCalc(i: Int, j: Int) {
    print(i + j)
}

performCalc(i: 1, j: 2)

var calc = performCalc
calc(1,2)

func performCalcWithClosure(closure: (Int, Int) -> Void) {
    closure(1, 2)
}

performCalcWithClosure(closure: calc)

var a: Int
var b: Int

performCalcWithClosure { (first, second) in
    self.a = first
    self.b = second
}

print("\(a) \(b)")

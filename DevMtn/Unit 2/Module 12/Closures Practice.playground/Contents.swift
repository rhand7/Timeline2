import UIKit

func printString(_ string: String) {
    print("Printing the string passed in as an argument: \(string)")
}

printString("Hi my name is Rob")

let stringPrinterFunction = printString
stringPrinterFunction("Hi, look at me")


func sum(a: Int, b: Int) -> Int {
    return a + b
}

let addTwoNumbers = sum
addTwoNumbers(1,2)

//Functions as Parameters 

func displayString(usingFunction function: (String) -> Void) {   //function: is a constant
    function("I'm a function inside a function")
}

displayString(usingFunction: printString)






















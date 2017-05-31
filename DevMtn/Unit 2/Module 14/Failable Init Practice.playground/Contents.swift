import UIKit

class Person {

    let name = String
    let age = Int
    let favoriteMovie = String
    
    init(name: String, age: Int, favoriteMovie: String) {
        
        self.name = name
        self.age = age
        self.favoriteMovie = favoriteMovie
        
    }
    
    init?(dictionary: [String: Any]) {
        
        guard let name = dictionary["name"] as? String,
        let age = dictionary["age"] as? Int,
            let favoriteMovie = dictionary["favMovie"] as? String else {
                
                return nil
        }
        
        self.name = name
        self.age = age
        self.favoriteMovie = favoriteMovie
    }
}

//Class to Dictionary 

let newDictionary = Person(name: "Bill", age: 42, favoriteMovie: "Zoolander")
print("\(newDictionary.name) \(newDictionary.age) \(newDictionary.favoriteMovie)") 
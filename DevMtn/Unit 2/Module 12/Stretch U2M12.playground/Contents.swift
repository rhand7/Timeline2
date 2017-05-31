import UIKit

//MARK: Protocol Vehicle
protocol Vehicle {
    var speed: Double { get set }
    var isMoving: Bool { get set }
    
    //Need to be mutating b/c we are changing property 'isMoving' w/in the method
    mutating func startMoving()
    mutating func stopMoving()
}

extension Vehicle {
    
    mutating func startMoving() {
        if !isMoving {
            isMoving = true
            print("We are now moving")
        } else {
            print("We are already moving")
        }
    }
    
    mutating func stopMoving() {
        if isMoving {
            isMoving = false
            print("We have stopped")
        } else {
            print("We have arleady stopped")
        }
    }
}
//MARK: Racer protocol

protocol Racer: Vehicle {
    var description: String { get set }
    func race() -> Double
}

extension Racer {
    func race() -> Double {
        return (1000.0 / speed)
    }
}

//MARK: Lawnmower class
class Lawnmower: Vehicle {
    var speed: Double
    var isMoving: Bool
    
    init(speed: Double, isMoving: Bool) {
        self.speed = speed
        self.isMoving = isMoving
    }
}

//MARK: Truck class
class Truck: Vehicle {
    var speed: Double
    var isMoving: Bool
    
    init(speed: Double, isMoving: Bool) {
        self.speed = speed
        self.isMoving = isMoving
    }
}


//MARK: Car class, since Car conforms to Racer and Racer conforms to Vehicle, we must conform to Vehicle as well
class Car: Racer {
    var speed: Double
    var isMoving: Bool
    var description: String
    
    init(speed: Double, isMoving: Bool, description: String) {
        self.speed = speed
        self.isMoving = isMoving
        self.description = description
    }
}

func winnerFrom(racer1: Racer, racer2: Racer) -> Racer {
    return racer1.race() < racer2.race() ? racer1 : racer2
}

var truck = Truck(speed: 45.0, isMoving: true)
var lawnmower = Lawnmower(speed: 15.0, isMoving: true)

truck.startMoving()
lawnmower.startMoving()

let mustang = Car(speed: 120.0, isMoving: true, description: "Mustang")
let civic = Car(speed: 90.0, isMoving: true, description: "Civic")

let winner = winnerFrom(racer1: mustang, racer2: civic)
print(winner.description) 

//
//  main.swift
//  C16_Optional_Chaining
//
//  Created by Andy Fang on 22/01/2024.
//

import Foundation

class Residence {
    var numberOfRooms = 1
}

class Person {
    var residence: Residence?
}

let john = Person()
// let roomCount = john.residence!.numberOfRooms
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

john.residence = Residence()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

// eg.2
class Room {
    let name: String
 
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?

    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

class ResidenceV2 {
    var rooms: [Room] = []
    var numberOfRooms: Int {
        return rooms.count
    }

    subscript(i: Int) -> Room {
        get {
            rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
 
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
 
    var address: Address?
}

class PersonV2 {
    var residence: ResidenceV2?
}

let bob = PersonV2()
if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
bob.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called.")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}
bob.residence?.address = createAddress()


/** Calling Methods Through Optional Chaining */
if bob.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was not possible to print the number of rooms.")
}

if (bob.residence?.address = someAddress) != nil {
    print("It was possible to set the address.")
} else {
    print("It was not possible to set the address.")
}
print("")


/** Accessing Subscripts Through Optional Chaining */
if let firstRoomName = bob.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
bob.residence?[0] = Room(name: "Bathroom")

let bobHouse = ResidenceV2()
bobHouse.rooms.append(Room(name: "Living Room"))
bobHouse.rooms.append(Room(name: "Kitchen"))
bob.residence = bobHouse
if let firstRoomName = bob.residence?[0].name {
    print("The first room name is \(firstRoomName).")
} else {
    print("Unable to retrieve the first room name.")
}
print("")


/** Accessing Subscripts of Optional Type */
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72


/** Linking Multiple Levels of Chaining */
if let bobStreet = bob.residence?.address?.street {
    print("John's street name is \(bobStreet).")
} else {
    print("Unable to retrieve the address.")
}

let bobAddress = Address()
bobAddress.buildingName = "The Larches"
bobAddress.street = "Laurel Street"
bob.residence?.address = bobAddress
if let bobStreet = bob.residence?.address?.street {
    print("John's street name is \(bobStreet).")
} else {
    print("Unable to retrieve the address.")
}


/** Chaining on Methods with Optional Return Values */
if let buildingIdentifier = bob.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildingIdentifier).")
}

if let beginsWithThe = bob.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier doesn't begin with \"The\".")
    }
}

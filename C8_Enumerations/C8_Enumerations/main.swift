//
//  main.swift
//  C8_Enumerations
//
//  Created by Andy Fang on 14/01/2024.
//

import Foundation

/** Enumeration Syntax */
//
enum CompassPoint {
    case north
    case south
    case east
    case west
}
// multiple cases
enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune
}
//
var directionToHead = CompassPoint.west
directionToHead = .east

// Matching Enumeration Values with a Switch Statement
directionToHead = .south
switch directionToHead {
    case .north:
        print("Lots of planets have a north")
    case .south:
        print("Watch out for penguins")
    case .east:
        print("Where the sun rises")
    case .west:
        print("Where the skies are blue")
}
//
let somePlanet = Planet.earth
switch somePlanet {
    case .earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
}

// Iterating over Enumeration Cases
// eg.1
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count
print("\(numberOfChoices) beverages available")
for beverage in Beverage.allCases {
    print(beverage)
}

// Associated Values
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")
switch productBarcode {
    case .upc(let numberSystem, let manufacturer, let product, let check):
        print("UPC: \(numberSystem), \(manufacturer), \(product), \(check).")
    case .qrCode(let productCode):
        print("QR code: \(productCode).")
}
switch productBarcode {
    case let .upc(numberSystem, manufacturer, product, check):
        print("UPC : \(numberSystem), \(manufacturer), \(product), \(check).")
    case let .qrCode(productCode):
        print("QR code: \(productCode).")
}

/** Raw Values */
// enumeration cases can come prepopulated with default values (called raw values)
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}
// Implicitly Assigned Raw Values
/* when integers are used for raw values,
   the implicit value for each case is one more than the previous case. 
   If the first case doesn’t have a value set, its value is 0.
 */
enum Planet2: Int, CaseIterable {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}
for p in Planet2.allCases {
    print("case: \(p), rawValue: \(p.rawValue)")
}
print("")
/* When strings are used for raw values,
   the implicit value for each case is the text of that case’s name.
 */
enum CompassPoint2: String, CaseIterable {
    case north, south, east, west
}
for c in CompassPoint2.allCases {
    print("case: \(c), rawValue: \(c.rawValue)")
}
print("")

// Initializing from a Raw Value

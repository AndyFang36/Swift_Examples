//
//  main.swift
//  C9_Structures_Classes
//
//  Created by Andy Fang on 14/01/2024.
//

import Foundation

// define
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
// instances
let someResolution = Resolution()
let someVideoMode = VideoMode()
// accessing
print("The width of someResolution is \(someResolution.width)")
print("The width of someVideoMode is \(someVideoMode.resolution.width)")
someVideoMode.resolution.width = 1280
print("The width of someVideoMode is now \(someVideoMode.resolution.width)")

// Memberwise Initializers for Structure Types
let vga = Resolution(width: 640, height: 480)

// Structures and Enumerations Are Value Types
// all of the basic types in Swift — integers, floating-point numbers, Booleans, strings, arrays and dictionaries — are value type
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")
// same to enum
enum CompassPoint {
    case north, south, east, west
    mutating func turnNorth() {
        self = .north
    }
}
var currentDirection = CompassPoint.west
let rememberedDirection = currentDirection
currentDirection.turnNorth()
print("The current direction is \(currentDirection)")
print("The remembered direction is \(rememberedDirection)")

// Classes Are Reference Types
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0
let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

// Identity Operators
// Identical to (===)
// Not identical to (!==)
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same VideoMode instance.")
}

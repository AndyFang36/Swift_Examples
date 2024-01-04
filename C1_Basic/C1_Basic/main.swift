//
//  main.swift
//  SwiftExamples
//
//  Created by Andy Fang on 1/1/24.
//

import Foundation


// Declaring Constants and Variables
// let maximumNumberOfLoginAttempts = 10
// var currentLoginAttempt = 0


var environment = "development"
let maxmNumberOfLoginAttempts: Int
// maximumNumberOfLoginAttempts has no value yet.

if environment == "development" {
    maxmNumberOfLoginAttempts = 100
} else {
    maxmNumberOfLoginAttempts = 10
}
// Now maximumNumberOfLoginAttempts has a value, and can be read.


// Declaring multiple constants or multiple variables on a single line:
var x = 0.0, y = 0.0, z = 0.0


// Type Annotations
var welcomeMessage: String
welcomeMessage = "Hello"
// Defining multiple related variables of the same type on a single line
var red, green, blue: Double

// Naming Constants and Variables
// Note: avoid using keywords as names
let π = 3.14159
let 你好 = "你好世界"
let 🐶🐮 = "dogcow"

var friendlyWelcome = "Hello!"
friendlyWelcome = "Bonjour!"
// friendlyWelcome is now "Bonjour!"
let languageName = "Swift"
//! languageName = "Swift++"
// This is a compile-time error: languageName cannot be changed.

print(friendlyWelcome, terminator: "");
print(friendlyWelcome, "");
print("The current value of friendlyWelcome is \(friendlyWelcome)")


/* This is also a comment
but is written over multiple lines. */

// Integers
let minValue = UInt8.min  // minValue is equal to 0, and is of type UInt8
let maxValue = UInt8.max  // maxValue is equal to 255, and is of type UInt8

// Type Safety and Type Inference

let meaningOfLife = 42
let pi = 3.14159
let anotherPi = 3 + 0.14159

// Numeric Literals
let decimalInteger = 17
let binaryInteger = 0b10001       // 17 in binary notation
let octalInteger = 0o21           // 17 in octal notation
let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
// floating-point literals
let decimalDouble = 12.1875
let exponentDouble = 1.21875e1
let hexadecimalDouble = 0xC.3p0
// Numeric literals can contain extra formatting to make them easier to read.
let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1

// Numeric Type Conversion
//! let cannotBeNegative: UInt8 = -1
// UInt8 can't store negative numbers, and so this will report an error
//! let tooBig: Int8 = Int8.max + 1
// Int8 can't store a number larger than its maximum value,
let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
// Integer and Floating-Point Conversion
let three = 3
let pointOneFourOneFiveNine = 0.14159
let piNew = Double(three) + pointOneFourOneFiveNine
// pi equals 3.14159, and is inferred to be of type Double
let intPi = Int(piNew)

// Type Aliases
typealias AudioSample = UInt16
var maxAmplitudeFound = AudioSample.min
print(maxAmplitudeFound)

// Booleans
let orangesAreOrange = true
let turnipsAreDelicious = false
if turnipsAreDelicious {
    print("Mmm, tasty turnips!")
} else {
    print("Eww, turnips are horrible.")
}
//! let i = 1
//! if i {
    // this example will not compile, and will report an error
//! }
let i = 1
if i == 1 {
    // this example will compile successfully
}

// Tuples
let http404Error = (404, "Not Found")
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode)")
print("The status message is \(statusMessage)")
/* If you only need some of the tuple’s values,
   ignore parts of the tuple with an underscore (_) when you decompose the tuple:
*/
let (justTheStatusCode, _) = http404Error
print("The status code is \(justTheStatusCode)")
/* Using index numbers to access the individual element values
 */
print("The status code is \(http404Error.0)")
print("The status message is \(http404Error.1)")
// Naming elements
let http200Status = (statusCode: 200, description: "OK")
print("The status code is \(http200Status.statusCode)")
print("The status message is \(http200Status.description)")


// Optionals
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber)
// nil
var serverResponseCode: Int? = 404
serverResponseCode = nil
// default value
var surveyAnswer: String?
// If an optional has a value, it’s considered as “not equal to” nil:
if convertedNumber != nil {
    print("convertedNumber contains some integer value.")
}

// Optional Binding
if let actualNumber = Int(possibleNumber) {
    print("The string \"\(possibleNumber)\" has an integer value of \(actualNumber)")
} else {
    print("The string \"\(possibleNumber)\" couldn't be converted to an integer")
}
// using the same name
let myNumber = Int(possibleNumber)
if let myNumber = myNumber {
    print("My number is \(myNumber)")
}
if let myNumber {
    print("My number is \(myNumber)")
}
// You can use both constants and variables with optional binding.
if let firstNumber = Int("4"), let secondNumber = Int("42"), firstNumber < secondNumber && secondNumber < 100 {
    print("\(firstNumber) < \(secondNumber) < 100")
}
if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}

// Providing a Fallback Value
let name: String? = nil
let greeting = "Hello, " + (name ?? "friend") + "!"
print(greeting)

// Force Unwrapping
/*  you can access the underlying value by adding `!` to the end of the optional’s name
 When you force unwrap a non-nil value, the result is its unwrapped value,
 force unwrapping a nil value triggers a runtime error.
 */
let number = convertedNumber!
guard let number = convertedNumber else {
    // The `!` is a shorter spelling of fatalError(_:file:line:).
    fatalError("The number was invalid!")
}
print(number)

// Implicitly Unwrapped Optionals
let possibleString: String? = "An optional string."
let forcedString: String = possibleString! // Requires explicit unwrapping
let assumedString: String! = "An implicitly unwrapped optional string."
let implicitString: String = assumedString // Unwrapped automatically
let optionalString = assumedString
if assumedString != nil {
    print(assumedString!)
}
if let definiteString = assumedString {
    print(definiteString)
}


// Error Handling
//func makeASandwich() throws {
//    // ...
//}
//
//
//do {
//    try makeASandwich()
//    // eatASandwich()
//} catch SandwichError.outOfCleanDishes {
//    // washDishes()
//} catch SandwichError.missingIngredients(let ingredients) {
//    // buyGroceries(ingredients)
//}


// Debugging with Assertions
let age = -3
assert(age >= 0, "A person's age can't be less than zero.")
if age > 10 {
    print("You can ride the roller-coaster or the ferris wheel.")
} else if age >= 0 {
    print("You can ride the ferris wheel.")
} else {
    assertionFailure("A person's age can't be less than zero.")
}

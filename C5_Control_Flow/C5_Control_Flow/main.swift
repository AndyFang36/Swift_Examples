//
//  main.swift
//  C5_Control_Flow
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/controlflow
//  Created by Andy Fang on 1/6/24.
//

/**
 Swift provides a variety of control flow statements.
 These include while loops to perform a task multiple times;
 if, guard, and switch statements to execute different branches of code based on certain conditions;
 and statements such as break and continue to transfer the flow of execution to another point in your code.
 Swift provides a for-in loop that makes it easy to iterate over arrays, dictionaries, ranges, strings, and other sequences.
 Swift also provides defer statements, which wrap code to be executed when leaving the current scope.
 */

import Foundation

// For-In Loops
// iterating over the items in an array
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names {
    print("Hello, \(name)!")
}
// iterate over a dictionary
let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
for (animalName, legCount) in numberOfLegs {
    print("\(animalName)s have \(legCount) legs")
}
// with numeric ranges
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// ignoring the values by using an underscore in place of a variable name.
let base = 3
let power = 10
var answer = 1
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")
print("")
// half-open range operator (..<)
let minutes = 60
for tickMark in 0..<minutes {
    print(tickMark, terminator: ", ")
}
print("\n")
// Use the stride(from:to:by:) function to skip the unwanted marks.
let minuteInterval = 15
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    print(tickMark)
}
print("")
// Closed ranges are also available, by using stride(from:through:by:)
let hours = 12
let hourInterval = 3
for tickMark in stride(from: 3, through: hours, by: hourInterval) {
    print(tickMark)
}
print("")


/** While Loops */
let finalSquare = 25
var board = [Int](repeating: 0, count: finalSquare + 1)
board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
var square = 0
var diceRoll = 0
while square < finalSquare {
    diceRoll += 1
    if diceRoll == 7 {
        diceRoll = 1
        // the dice roll has become too large and is reset to a value of 1
    }
    square += diceRoll  // move by the rolled amount
    print("move by dice", square)
    if square < board.count {
        // if we're still on the board, move up or down for a snake or a ladder
        square += board[square]
    }
    print(square)
}
print("Game over!\n")

/** Repeat-While (do-while) */
/* Here’s the Snakes and Ladders example again,
   written as a repeat-while loop rather than a while loop.
 */
square = 0  // reset to 0
diceRoll = 0  // reset to 0
repeat {
    // move up or down for a snake or ladder
    square += board[square]
    print("at square \(square)", terminator: ", ")
    // roll the dice
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    // move by the rolled amount
    square += diceRoll
    print("after dice: ", square)
} while square < finalSquare
print("Game over!\n")


// Conditional Statements
// if
var temperatureInFahrenheit = 30
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
}
// if-else
temperatureInFahrenheit = 40
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// if -> else-if -> else
temperatureInFahrenheit = 90
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
} else {
    print("It's not that cold. Wear a T-shirt.")
}
// else is optional
temperatureInFahrenheit = 72
if temperatureInFahrenheit <= 32 {
    print("It's very cold. Consider wearing a scarf.")
} else if temperatureInFahrenheit >= 86 {
    print("It's really warm. Don't forget to wear sunscreen.")
}
// setting values
let temperatureInCelsius = 25
let weatherAdvice: String
if temperatureInCelsius <= 0 {
    weatherAdvice = "It's very cold. Consider wearing a scarf."
} else if temperatureInCelsius >= 30 {
    weatherAdvice = "It's really warm. Don't forget to wear sunscreen."
} else {
    weatherAdvice = "It's not that cold. Wear a T-shirt."
}
print(weatherAdvice)
// if expression
let weatherAdvice2 = if temperatureInCelsius <= 0 {
    "It's very cold. Consider wearing a scarf."
} else if temperatureInCelsius >= 30 {
    "It's really warm. Don't forget to wear sunscreen."
} else {
    "It's not that cold. Wear a T-shirt."
}
print(weatherAdvice2)
// you need to specify the type explicitly
let freezeWarning: String? = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil
}
print(freezeWarning!)
//
let freezeWarning2 = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil as String?
}
print(freezeWarning2!)
//
let weatherAdvice3 = if temperatureInCelsius > 100 {
    throw fatalError()
    // throw TemperatureError.boiling
} else {
    "It's a reasonable temperature."
}
print(weatherAdvice3)

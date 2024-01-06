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
    // render the tick mark each minute (60 times)
}
print("")
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
print("Game over!")

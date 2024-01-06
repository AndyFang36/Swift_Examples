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
// print(freezeWarning)
//
let freezeWarning2 = if temperatureInCelsius <= 0 {
    "It's below freezing. Watch for ice!"
} else {
    nil as String?
}
// print(freezeWarning2)
//
//let weatherAdvice3 = if temperatureInCelsius > 100 {
//    throw fatalError()
//    // throw TemperatureError.boiling
//} else {
//    "It's a reasonable temperature."
//}
//print(weatherAdvice3)


/** Switch */
var someCharacter: Character = "z"
switch someCharacter {
    case "a":
        print("The first letter of the Latin alphabet")
    case "z":
        print("The last letter of the Latin alphabet")
    default:
        print("Some other character")
}
//
let anotherCharacter: Character = "a"
let message = switch anotherCharacter {
case "a":
    "The first letter of the Latin alphabet"
case "z":
    "The last letter of the Latin alphabet"
default:
    "Some other character"
}
print(message)
//
let anotherCharacter2: Character = "a"
switch anotherCharacter2 {
    case "a", "A":
        print("The letter A")
    default:
        print("Not the letter A")
}
// Interval Matching
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
let naturalCount: String
switch approximateCount {
    case 0:
        naturalCount = "no"
    case 1..<5:
        naturalCount = "a few"
    case 5..<12:
        naturalCount = "several"
    case 12..<100:
        naturalCount = "dozens of"
    case 100..<1000:
        naturalCount = "hundreds of"
    default:
        naturalCount = "many"
}
print("There are \(naturalCount) \(countedThings).")
// Tuples
let somePoint = (1, 1)
switch somePoint {
    case (0, 0):
        print("\(somePoint) is at the origin")
    case (_, 0):
        print("\(somePoint) is on the x-axis")
    case (0, _):
        print("\(somePoint) is on the y-axis")
    case (-2...2, -2...2):
        print("\(somePoint) is inside the box")
    default:
        print("\(somePoint) is outside of the box")
}
print("")
// Value Bindings
let anotherPoint = (2, 0)
switch anotherPoint {
    case (let x, 0):
        print("on the x-axis with an x value of \(x)")
    case (0, let y):
        print("on the y-axis with a y value of \(y)")
    case let (x, y):
        print("somewhere else at (\(x), \(y))")
}
print("")
// Where
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y:
        print("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:
        print("(\(x), \(y)) is on the line x == -y")
    case let (x, y):
        print("(\(x), \(y)) is just some arbitrary point")
}
print("")
// Compound Cases
someCharacter = "e"
switch someCharacter {
    case "a", "e", "i", "o", "u":
        print("\(someCharacter) is a vowel")
    case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
        "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
        print("\(someCharacter) is a consonant")
    default:
        print("\(someCharacter) isn't a vowel or a consonant")
}
print("")
//
let stillAnotherPoint = (9, 0)
switch stillAnotherPoint {
    case (let distance, 0), (0, let distance):
        print("On an axis, \(distance) from the origin")
    default:
        print("Not on an axis")
}
print("")


/** Control Transfer Statements */
// Continue
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
for character in puzzleInput {
    if charactersToRemove.contains(character) {
        continue
    }
    puzzleOutput.append(character)
}
print(puzzleOutput)
// Break
let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
    case "1", "١", "一", "๑":
        possibleIntegerValue = 1
    case "2", "٢", "二", "๒":
        possibleIntegerValue = 2
    case "3", "٣", "三", "๓":
        possibleIntegerValue = 3
    case "4", "٤", "四", "๔":
        possibleIntegerValue = 4
    default:
        break
}
if let integerValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(integerValue).")
} else {
    print("An integer value couldn't be found for \(numberSymbol).")
}
// Fallthrough
let integerToDescribe = 5
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
    case 2, 3, 5, 7, 11, 13, 17, 19:
        description += " a prime number, and also"
        fallthrough
    default:
        description += " an integer."
}
print(description, terminator: "\n\n")
// Labeled Statements
/* This  example uses the break and continue statements with a labeled while loop for an adapted version of the Snakes and Ladders game.
   This time around, the game has an extra rule:
   To win, you must land exactly on square 25.
 */
square = 0
diceRoll = 0
gameLoop: while square != finalSquare {
    diceRoll += 1
    if diceRoll == 7 { diceRoll = 1 }
    switch square + diceRoll {
        case finalSquare:
            // diceRoll will move us to the final square, so the game is over
            break gameLoop
        case let newSquare where newSquare > finalSquare:
            // diceRoll will move us beyond the final square, so roll again
            continue gameLoop
        default:
            // this is a valid move, so find out its effect
            square += diceRoll
            square += board[square]
    }
}
print("Game over!\n")
// Early Exit
func greet(person: [String: String]) {
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)!")
    guard let location = person["location"] else {
        print("I hope the weather is nice near you.")
        return
    }
    print("I hope the weather is nice in \(location).")
}
greet(person: ["name": "John"])
greet(person: ["name": "Jane", "location": "Cupertino"])
print("")
// Deferred Actions
var score = 1
if score < 10 {
    defer {
        print(score)
    }
    score += 5
}
//
score = 3
if score < 100 {
    score += 100
    defer {
        score -= 100
    }
    // Other code that uses the score with its bonus goes here.
    print(score)
}
/* If you write more than one defer block in the same scope,
   the first one you specify is the last one to run
 */
if score < 10 {
    defer {
        print(score)
    }
    defer {
        print("The score is:")
    }
    score += 5
}

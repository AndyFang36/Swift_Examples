//
//  main.swift
//  C07_Closures
//
//  Created by Andy Fang on 13/01/2024.
//

/** Closures take one of three forms:
 Global functions are closures that have a name and don’t capture any values.
 Nested functions are closures that have a name and can capture values from their enclosing function.
 Closure expressions are unnamed closures written in a lightweight syntax that can capture values from their surrounding context.
 */

import Foundation

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
print(reversedNames)

// Closure Expression Syntax
reversedNames = names.sorted(by: {
    (s1: String, s2: String) -> Bool in return s1 > s2
})
print(reversedNames)
// Implicit Returns from Single-Expression Closures
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
print(reversedNames)
// Shorthand Argument Names
reversedNames = names.sorted(by: { $0 > $1 } )
print(reversedNames)
// Operator Methods
reversedNames = names.sorted(by: >)
print(reversedNames)

// Trailing Closures
reversedNames = names.sorted() { $0 > $1 }
print(reversedNames)
reversedNames = names.sorted { $0 > $1 }
print(reversedNames)
//
let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
let strings = numbers.map { number -> String in
    var n = number
    var output = ""
    repeat {
        output = digitNames[n % 10]! + output
        n /= 10
    } while n > 0
    return output
}

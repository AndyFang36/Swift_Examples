//
//  main.swift
//  C2_Operators
//
//  Created by Andy Fang on 1/3/24.
//

import Foundation

print("Hello, World!")

// Assignment Operator
let b = 10
var a = 5
a = b
print(a, b)
// tuple
let (x, y) = (1, 2)
print(x, y)

// Arithmetic Operators
let v1 = 1 + 1
let v2 = 5 - 3
let v3 = 2 * 3
let v4 = 10.0 / 2.5
let str = "hello" + "world"

// Remainder Operator
let remain = 9 % 4
print(remain)

// Unary Minus Operator
let three = 3
let minusThree = -three
let plusThree = -minusThree
print(three, minusThree, plusThree)

// Unary Plus Operator
let minusSix = -6
let alsoMinusSix = +minusSix
print(minusSix, alsoMinusSix)

// Compound Assignment Operators
var 😀 = 1
😀 += 2
print(😀)

// Comparison Operators
let name = "world"
if name == "world" {
    print("hello, world")
} else {
    print("I'm sorry \(name), but I don't recognize you")
}
// You can compare two tuples if they have the same type and the same number of values.
// (1, "zebra") < (2, "apple")   // true because 1 is less than 2; "zebra" and "apple" aren't compared
// (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
// (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"

// Ternary Conditional Operator
let contentHeight = 40
let hasHeader = true
let rowHeight = contentHeight + (hasHeader ? 50 : 20)

// Nil-Coalescing Operator
let defaultColorName = "red"
var userDefinedColorName: String?   // defaults to nil
var colorNameToUse = userDefinedColorName ?? defaultColorName
userDefinedColorName = "green"
colorNameToUse = userDefinedColorName ?? defaultColorName
print(colorNameToUse)


/** Range Operators */
// 1. closed range operators: (a..b)
for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}
// 2. half-open range: (a..<b)
let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count
for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}
// 3.One-Side ranges:
for name in names[2...]{
    print(name)
}
print("-----------------")
for name in names[...2]{
    print(name)
}
print("-----------------")
for name in names[..<2] {
    print(name)
}
let range = ...5
print(range.contains(7))
print(range.contains(4))
print(range.contains(-1))

/** Logical Operators */
// 1. NOT (!)
let allowedEntry = false
if !allowedEntry {
    print("ACCESS DENIED")
}
//2. AND (&&)
let enteredDoorCode = true
let passedRetinaScan = false
if enteredDoorCode && passedRetinaScan {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 3. OR (||)
let hasDoorKey = false
let knowsOverridePassword = true
if hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 4.Combining Logical Operators
if enteredDoorCode && passedRetinaScan || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}
// 5. Explicit Parentheses
if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
    print("Welcome!")
} else {
    print("ACCESS DENIED")
}

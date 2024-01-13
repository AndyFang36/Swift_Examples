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
//

//func loadPicture(from server: String,
//                 completion: (Picture) -> Void,
//                 onFailure: () -> Void) {
//    if let picture = download("photo.jpg", from: server) {
//        completion(picture)
//    } else {
//        onFailure()
//    }
//}
//loadPicture(from: someServer) { picture in
//    someView.currentPicture = picture
//} onFailure: {
//    print("Couldn't download the next picture.")
//}

// Capturing Values
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
print(incrementByTen())
print(incrementByTen())
print(incrementByTen())
let incrementBySeven = makeIncrementer(forIncrement: 7)
print(incrementBySeven())
print(incrementBySeven())
print(incrementBySeven())
print(incrementByTen())
let alseIncrementByTen = incrementByTen
print(alseIncrementByTen())
print(incrementByTen())

// Escaping Closures
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()
print(instance.x)
//
class SomeOtherClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { [self] in x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}
let instance2 = SomeOtherClass()
instance2.doSomething()
print(instance2.x)
completionHandlers[1]()
print(instance2.x)
//
struct SomeStruct {
    var x = 10
    mutating func doSomething() {
        someFunctionWithNonescapingClosure { x = 200 }  // Ok
        // someFunctionWithEscapingClosure { x = 100 }     // Error
    }
}

// Autoclosures
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
print("Now serving \(customerProvider())!")
print(customersInLine.count)
//
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) })
// Overusing autoclosures can make your code hard to understand.
// The context and function name should make it clear that evaluation is being deferred.
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
//
var customerProviders: [() -> String] = []
func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}
collectCustomerProviders(customersInLine.remove(at: 0))
collectCustomerProviders(customersInLine.remove(at: 0))
print("Collected \(customerProviders.count) closures.")
for customerProvider in customerProviders {
    print("Now serving \(customerProvider())!")
}

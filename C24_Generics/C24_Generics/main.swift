//
//  main.swift
//  C24_Generics
//  Write code that works for multiple types and specify requirements for those types.
//  Created by Andy Fang on 07/02/2024.
//

import Foundation

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}

var someInt = 3
var anotherInt = 107
swapTwoInts(&someInt, &anotherInt)
print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")


/* Generic Functions */
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA = a
    a = b
    b = temporaryA
}
// eg.1
var someInt2 = 3
var anotherInt2 = 107
swapTwoValues(&someInt, &anotherInt)
// eg.2
var someString = "hello"
var anotherString = "world"
swapTwoValues(&someString, &anotherString)


/* Generic Types */
struct IntStack {
    var items: [Int] = []

    mutating func push(_ item: Int) {
        items.append(item)
    }

    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items: [Element] = []

    mutating func push(_ item: Element) {
        items.append(item)
    }

    mutating func pop() -> Element {
        return items.removeLast()
    }
}

var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")
stackOfStrings.push("cuatro")
let fromTheTop = stackOfStrings.pop()
print(stackOfStrings.items)


/* Extending a Generic Type */
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

if let topItem = stackOfStrings.topItem {
    print("The top item on the stack is \(topItem).")
}


/* Type Constraints */
func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    print("The index of llama is \(foundIndex)")
}

//! func findIndex<T>(of valueToFind: T, in array:[T]) -> Int? {
//!     for (index, value) in array.enumerated() {
//!         if value == valueToFind {
//!             return index
//!         }
//!     }
//!     return nil
//! }

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.3, in: [3.14159, 0.1, 0.25])
let stringIndex = findIndex(of: "Andrea", in: ["Mike", "Malcolm", "Andrea"])


/* Associated Types */
protocol Container {
    associatedtype Item//: Equatable  // Adding Constraints to an Associated Type
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
    
//    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
//    func makeIterator() -> Iterator
}

struct StackV2<Element: Equatable>: Container {
    // original Stack<Element> implementation
    var items: [Element] = []
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }

    // conformance to the Container protocol
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }

}

// Extending an Existing Type to Specify an Associated Type
extension Array: Container {}

// Using a Protocol in Its Associated Type’s Constraints
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}

extension StackV2: SuffixableContainer {
    func suffix(_ size: Int) -> StackV2 {
        var result = StackV2()
        for index in (count-size)..<count {
            result.append(self[index])
        }
        return result
    }
    // Inferred that Suffix is Stack.
}

var stackOfInts = StackV2<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
print(suffix)
print("")


/* Generic Where Clauses */
func allItemsMatch<C1: Container, C2: Container>(_ someContainer: C1, _ anotherContainer: C2) -> Bool
where C1.Item == C2.Item, C1.Item: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

var stackOfStringsV2 = StackV2<String>()
stackOfStringsV2.push("uno")
stackOfStringsV2.push("dos")
stackOfStringsV2.push("tres")
var arrayOfStrings = ["uno", "dos", "tres"]
if allItemsMatch(stackOfStringsV2, arrayOfStrings) {
    print("All items match.")
} else {
    print("Not all items match.")
}
print("")


/* Extensions with a Generic Where Clause */
extension StackV2 where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

if stackOfStringsV2.isTop("tres") {
    print("Top element is tres.")
} else {
    print("Top element is something else.")
}

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 9, 9].startsWith(42) {
    print("Starts with 42.")
} else {
    print("Starts with something else.")
}

extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

print([1260.0, 1200.0, 98.6, 37.0].average())
print("")


/* Contextual Where Clauses */
extension Container {
    func average() -> Int where Item == Int {
        var sum = 0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / count
    }

    func endsWith(_ item: Item) -> Bool where Item: Equatable {
        return count >= 1 && self[count-1] == item
    }
}

let numbers: [Int] = [1, 2, 3, 4]
print(numbers.average())
print(numbers.endsWith(37))


extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var result: [Item] = []
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

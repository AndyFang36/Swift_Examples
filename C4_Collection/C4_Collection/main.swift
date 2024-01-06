//
//  main.swift
//  C4_Collection
//  https://docs.swift.org/swift-book/documentation/the-swift-programming-language/collectiontypes
//  Created by Andy Fang on 1/6/24.
//

import Foundation

// Arrays
// 1. Creating an Empty Array
var someInts: [Int] = []
print("someInts is of type [Int] with \(someInts.count) items.")
someInts.append(3)
someInts = []
// 2. Creating an Array with a Default Value
var threeDoubles = Array(repeating: 0.0, count: 3)
print(threeDoubles)
// 3. Creating an Array by Adding Two Arrays Together
var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles
print(sixDoubles)
// 4. Creating an Array with an Array Literal
var shoppingList: [String] = ["Eggs", "Milk"]
print(shoppingList)
var shoppingList2 = ["Eggs", "Milk"]  // Thanks to Swift’s type inference

// Accessing and Modifying an Array
// count
print("The shopping list contains \(shoppingList.count) items.")
// isEmpty()
if shoppingList.isEmpty {
    print("The shopping list is empty.")
} else {
    print("The shopping list isn't empty.")
}
// append()
shoppingList.append("Flour")
print(shoppingList)
shoppingList += ["Baking Powder"]
print(shoppingList)
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
print(shoppingList)
// accessing
var firstItem = shoppingList[0]
print(firstItem)
shoppingList[0] = "Six eggs"
print(shoppingList)
shoppingList[4...6] = ["Bananas", "Apples"]
print(shoppingList)
// insert()
shoppingList.insert("Maple Syrup", at: 0)
print(shoppingList)
// remove()
let mapleSyrup = shoppingList.remove(at: 0)
print(shoppingList)
let apples = shoppingList.removeLast()
print(shoppingList)

// Iterating Over an Array
for item in shoppingList {
    print(item)
}
for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}


// Sets
// Creating and Initializing an Empty Set
var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")
letters.insert("a")
letters = []
print(letters)
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres2: Set = ["Rock", "Classical", "Hip hop"]
print(favoriteGenres)
// Accessing and Modifying a Set
// count
print("I have \(favoriteGenres.count) favorite music genres.")
// isEmpty()
if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky.")
} else {
    print("I have particular music preferences.")
}
// insert()
favoriteGenres.insert("Jazz")
print(favoriteGenres, terminator: "\n\n")
// remove()
if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.", terminator: "\n\n")
}
// contain()
if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.", terminator: "\n\n")
}
// Iterating
for genre in favoriteGenres {
    print("\(genre)")
}
print("--------------")
for genre in favoriteGenres.sorted(by: <) {
    print("\(genre)")
}

// Performing Set Operations
let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
print(oddDigits.union(evenDigits).sorted())
print(oddDigits.intersection(evenDigits).sorted())
print(oddDigits.subtracting(singleDigitPrimeNumbers).sorted())
print(oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted())
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]
print(houseAnimals.isSubset(of: farmAnimals))
print(farmAnimals.isSuperset(of: houseAnimals))
print(farmAnimals.isDisjoint(with: cityAnimals))

/* Dictionaries */
// Creating
// 1. an Empty Dictionary
var namesOfIntegers: [Int: String] = [:]
namesOfIntegers[16] = "sixteen"
print(namesOfIntegers)
namesOfIntegers = [:]
print(namesOfIntegers)
// 2. a Dictionary Literal
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
print(airports)
var airports2 = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

// Accessing and Modifying a Dictionary
// count
print("The airports dictionary contains \(airports.count) items.")
// isEmpty()
if airports.isEmpty {
    print("The airports dictionary is empty.")
} else {
    print("The airports dictionary isn't empty.")
}
// adding
airports["LHR"] = "London"
print(airports)
airports["LHR"] = "London Heathrow"
print(airports, terminator: "\n\n")
// updating
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    print("The old value for DUB was \(oldValue).", terminator: "\n\n")
}
// removing
airports["APL"] = "Apple International"
print(airports)
airports["APL"] = nil
print(airports)
if let removedValue = airports.removeValue(forKey: "DUB") {
    print("The removed airport's name is \(removedValue).")
} else {
    print("The airports dictionary doesn't contain a value for DUB.", terminator: "\n\n")
}
// Iterating
for (airportCode, airportName) in airports {
    print("\(airportCode): \(airportName)")
}
for airportCode in airports.keys {
    print("Airport code: \(airportCode)")
}
for airportName in airports.values {
    print("Airport name: \(airportName)", terminator: "\n\n")
}

// initialize a new array with the keys or values property:
let airportCodes = [String](airports.keys),
    airportNames = [String](airports.values)
print("airport codes array:", airportCodes)
print("airport names array:", airportNames)

//
//  main.swift
//  C3_String
//
//  Created by Andy Fang on 1/5/24.
//

import Foundation

// String Literals
let someString = "Some string literal value"
print(someString)
var quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
print(quotation)
let softWrappedQuotation = """
The White Rabbit put on his spectacles.  "Where shall I begin, \
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on \
till you come to the end; then stop."
"""
print(softWrappedQuotation)
let lineBreaks = """

This string starts with a line break.
It also ends with a line break.

"""
print(lineBreaks)
let linesWithIndentation = """
    This line doesn't begin with whitespace.
        This line begins with four spaces.
    This line doesn't begin with whitespace.
    """
print(linesWithIndentation)

// Special Characters
print("null character: \0")
print("backslash: \\")
print("horizontal tab: \t")
print("line feed: \n")
print("carriage return: \r")
print("double quotation: \"")
print("single quotation mark: \'")
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"
print(wiseWords)
print(dollarSign)
print(blackHeart)
print(sparklingHeart)
let threeDoubleQuotationMarks = """
Escaping the first quotation mark \"""
Escaping all three quotation marks \"\"\"
"""
print(threeDoubleQuotationMarks)
// Extended String Delimiters
let threeMoreDoubleQuotationMarks = #"""
Here are three more double quotes: """
"""#
print(threeMoreDoubleQuotationMarks)


// Initializing an Empty String
var emptyString = ""
var anotherEmptyString = String()
print(emptyString, anotherEmptyString)
if emptyString.isEmpty {
    print("Nothing to see here")
}


// Characters
for char in "Dog!🐶" {
    print(char)
}
let exclamationMark: Character = "!"
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
let catString = String(catCharacters)
print(catString)

// Concatenating Strings and Characters
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
print(welcome)
var instruction = "look over"
instruction += string2
print(instruction)
// appending
welcome.append(exclamationMark)
print(welcome)
let badStart = """
    one
    two
    """
let end = """
    three
    """
print(badStart + end)
let goodStart = """
    one
    two

    """
print(goodStart + end)

// String Interpolation
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
print(message)
print(#"Write an interpolated string in Swift using \(multiplier)."#)
print(#"6 times 7 is \#(6 * 7)."#)


// Unicode
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"
print(eAcute, combinedEAcute)
let precomposed: Character = "\u{D55C}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
print(precomposed, decomposed)
let enclosedEAcute: Character = "\u{E9}\u{20DD}"
print(enclosedEAcute)
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
print(regionalIndicatorForUS)


// Counting Characters
let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
print("unusualMenagerie has \(unusualMenagerie.count) characters")
var word = "cafe"
print("the number of characters in \(word) is \(word.count)")
word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
print("the number of characters in \(word) is \(word.count)")


// Accessing and Modifying
var greeting = "Guten Tag!"
// let index: Int
var index = greeting.startIndex
print(greeting[index])
// The endIndex property is the position after the last character in a String
// index = greeting.endIndex
// print(greeting[index])
index = greeting.index(before: greeting.endIndex)
print("index: \(index)", greeting[index])
index = greeting.index(after: greeting.startIndex)
print("index: \(index)", greeting[index])
index = greeting.index(greeting.startIndex, offsetBy: 7)
print(greeting[index])
for index in greeting.indices {
    print("\(greeting[index]) ", terminator: "")
    
}
print("----------------------------------------------------------------------")
// Inserting and Removing
welcome = "hello"
welcome.insert("!", at: welcome.endIndex)
print(welcome)
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
print(welcome)
welcome.remove(at: welcome.index(before: welcome.endIndex))
print(welcome)
let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)
print(welcome)

// Substrings
greeting = "Hello, world!"
index = greeting.firstIndex(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]
print(beginning)
let newString = String(beginning)

// Comparing Strings
quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation {
    print("These two strings are considered equal")
}
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters aren't equivalent.")
}

// Prefix and Suffix Equality
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in romeoAndJuliet {
    act1SceneCount += (scene.hasPrefix("Act 1 ") ? 1 : 0)
}
print("There are \(act1SceneCount) scenes in Act 1")
// hasSuffix(_:)
var mansionCount = 0
var cellCount = 0
for scene in romeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    } else if scene.hasSuffix("Friar Lawrence's cell") {
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")


// Unicode Representations of Strings
let dogString = "Dog‼🐶"
// UTF-8
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ", terminator: "")
}
print("")
// UTF-16
for codeUnit in dogString.utf16 {
    print("\(codeUnit) ", terminator: "")
}
print("")

// Unicode Scalar Representation
for scalar in dogString.unicodeScalars {
    print("\(scalar.value) ", terminator: "")
}
print("")
for scalar in dogString.unicodeScalars {
    print("\(scalar) ")
}

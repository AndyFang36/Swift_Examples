//
//  main.swift
//  C23_Protocols
//  Define requirements that conforming types must implement.
//  Created by Andy Fang on 04/02/2024.
//

import Foundation

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNoNeedToBeSettable: Int { get }
}

protocol AnotherProtocol {
    static var someypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

// eg.1
struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
print(john.fullName)

// eg.2
class Starship: FullyNamed {
    var prefix: String?
    var name: String

    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }

    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
print(ncc1701.fullName)


/* Method Requirements */
protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 6.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("And another one: \(generator.random())")


/* Mutating Method Requirements */
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on

    mutating func toggle() {
        switch self {
            case .off:
                self = .on
            case .on:
                self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


/* Initializer Requirements */


/* Delegation */
class Dice {
    var sides: Int = 6
    var generator: LinearCongruentialGenerator
    
    func roll() -> Int {
        var random: Int
        repeat {
            random = Int(floor(generator.random() * 10))
        } while random < 1 || random > sides
        return random
    }
    
    init(sides: Int, generator: LinearCongruentialGenerator) {
        self.sides = sides
        self.generator = generator
    }
}

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate: AnyObject {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]

    init() {
        board = Array(repeating: 0, count: finalSquare + 1)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }

    weak var delegate: DiceGameDelegate?

    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop:
        while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
                case finalSquare:
                    break gameLoop
                case let newSquare where newSquare > finalSquare:
                    continue gameLoop
                default:
                    square += diceRoll
                    square += board[square]
            }
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0

    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is SnakesAndLadders {
            print("Started a new game of Snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }

    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }

    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()


/* Adding Protocol Conformance with an Extension */
protocol TextRepresentable {
    var textualDescription: String { get }
}

// eg.2
extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator()),
    d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
print(d6.textualDescription)
print(d12.textualDescription)

// eg.2
extension SnakesAndLadders: TextRepresentable {
    var textualDescription: String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
print(game.textualDescription)


/* Conditionally Conforming to a Protocol */
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let myDice = [d6, d12]
print(myDice.textualDescription)


/** Declaring Protocol Adoption with an Extension
 *  Types don’t automatically adopt a protocol just by satisfying its requirements.
 *  They must always explicitly declare their adoption of the protocol.
 */
struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simonTheHamster = Hamster(name: "Simon")
let somethingTextRepresentable: TextRepresentable = simonTheHamster
print(somethingTextRepresentable.textualDescription)


/* Adopting a Protocol Using a Synthesized Implementation */
struct Vector3D: Equatable {
    var x = 0.0, y = 0.0, z = 0.0
}

let twoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
let anotherTwoThreeFour = Vector3D(x: 2.0, y: 3.0, z: 4.0)
if twoThreeFour == anotherTwoThreeFour {
    print("These two vectors are also equivalent.")
}

// eg.2
enum SkillLevel: Comparable {
    case beginner
    case intermediate
    case expert(stars: Int)
}

var levels = [SkillLevel.intermediate, SkillLevel.beginner, SkillLevel.expert(stars: 5), SkillLevel.expert(stars: 3)]
for level in levels.sorted() {
    print(level)
}


/* Collections of Protocol Types */
let things: [TextRepresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.textualDescription)
}


/* Protocol Inheritance */
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = textualDescription + ":\n"
        for index in 1...finalSquare {
            switch board[index] {
                case let ladder where ladder > 0:
                    output += "▲ "
                case let snake where snake < 0:
                    output += "▼ "
                default:
                    output += "○ "
            }
        }
        return output
    }
}

print(game.prettyTextualDescription)


/* Class-Only Protocols */
protocol SomeInheritedProtocol {}

protocol SomeClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
    // class-only protocol definition goes here
}


/* Protocol Composition */
// eg.1
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct PersonV1: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = PersonV1(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)

// eg.2
class Location {
    var latitude: Double
    var longitude: Double

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String

    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        super.init(latitude: latitude, longitude: longitude)
    }
}

func beginConcert(in location: Location & Named) {
    print("Hello, \(location.name)!")
}

let seattle = City(name: "Seattle", latitude: 47.6, longitude: -122.3)
beginConcert(in: seattle)


/* Checking for Protocol Conformance */
protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = 3.1415927
    var radius: Double
    var area: Double { return pi * radius * radius }

    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double

    init(area: Double) { self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
print("")


/* Optional Protocol Requirements */
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?

    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

// eg.1
class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

// eg.2
class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}


/* Protocol Extensions */
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

print("Here's a random number: \(generator.random())")
print("And here's a random Boolean: \(generator.randomBool())")


/* Providing Default Implementations */
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}
print("")


/* Adding Constraints to Protocol Extensions */
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first {
                return false
            }
        }
        return true
    }
}

let equalNumbers = [100, 100, 100, 100, 100]
let differentNumbers = [100, 100, 200, 100, 200]
print(equalNumbers.allEqual())
print(differentNumbers.allEqual())

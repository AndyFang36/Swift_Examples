//
//  main.swift
//  C27_MemorySafety
//  Structure your code to avoid conflicts when accessing memory.
//  Created by Andy Fang on 07/02/2024.
//

import Foundation

// A write access to the memory where one is stored.
var one = 1
// A read access from the memory where one is stored.
print("We're number \(one)!")

func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)


/* Conflicting Access to In-Out Parameters */
var stepSize = 1

func increment(_ number: inout Int) {
    number += stepSize
}

//! increment(&stepSize)
var copyOfStepSize = stepSize
increment(&copyOfStepSize)
stepSize = copyOfStepSize


func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30
balance(&playerOneScore, &playerTwoScore)
//! balance(&playerOneScore, &playerOneScore)
print(playerOneScore, playerTwoScore)



struct Player {
    var name: String
    var health: Int
    var energy: Int
    static let maxHealth = 10

    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "Oscar", health: 10, energy: 10)
var maria = Player(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)  // OK
//! oscar.shareHealth(with: &oscar)  // Error: conflicting accesses to oscar
print(oscar.health, maria.health)


/* Conflicting Access to Properties */
func someFunction() {
    var oscar = Player(name: "Oscar", health: 10, energy: 10)
    balance(&oscar.health, &oscar.energy)  // OK
}

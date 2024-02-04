//
//  main.swift
//  C21_Nested_Types
//  Define types inside the scope of another type.
//
//  Created by Andy Fang on 04/02/2024.
//

import Foundation

// https://www.blackjack.org/wp-content/uploads/2021/06/Blackjack-card-values.png
struct BlackjackCard {
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
                case .ace:
                    return Values(first: 1, second: 11)
                case .jack, .queen, .king:
                    return Values(first: 10, second: nil)
                default:
                    return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")


/** Referring to Nested Types */
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
print(heartsSymbol)

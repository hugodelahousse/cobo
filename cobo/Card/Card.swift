//
//  Card.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation

enum CardColor: Codable, Equatable, Hashable {
    case red
    case black
}

enum Card: Codable, Equatable, Hashable, CustomStringConvertible {
    static let all: [Card] = [.ace, .two, .three, .four, .five, .six, .seven, .eight, .nine, .ten, .jack, .queen, .king(color: .black), .king(color: .red)]

    case ace
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king(color: CardColor)

    func value(blackKingValue: Int) -> Int {
        return switch self {
        case .ace: 1
        case .two: 2
        case .three: 3
        case .four: 4
        case .five: 5
        case .six: 6
        case .seven: 7
        case .eight: 8
        case .nine: 9
        case .ten, .jack, .queen: 10
        case .king(.red): 0
        case .king(.black): blackKingValue
        }
    }

    var description: String {
        return switch self {
        case .ace: "🂡"
        case .two: "🂢"
        case .three: "🂣"
        case .four: "🂤"
        case .five: "🂥"
        case .six: "🂦"
        case .seven: "🂧"
        case .eight: "🂨"
        case .nine: "🂩"
        case .ten, .jack, .queen: "🂪"
        case .king(.red): "🂾"
        case .king(.black): "🂮"
        }
    }
}

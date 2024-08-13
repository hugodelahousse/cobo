//
//  Card.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation

struct Card: Identifiable, Codable, Equatable, Hashable, CustomStringConvertible {
    enum Suite: Codable, Equatable, Hashable, CaseIterable {
        case heart
        case diamond
        case spade
        case club

        func isBlack() -> Bool {
            return self == .spade || self == .club
        }
    }

    enum Rank: Codable, Equatable, Hashable, CaseIterable {
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
        case king
    }

    let id = UUID()
    let rank: Card.Rank
    let suite: Card.Suite

    func value(blackKingValue: Int) -> Int {
        return switch rank {
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
        case .king: suite.isBlack() ? blackKingValue : 0
        }
    }

    var description: String {
        return "\(rank)(\(suite))"
    }
}

extension Card.Rank: CustomStringConvertible {
    var description: String {
        return switch self {
        case .ace: "1"
        case .two: "2"
        case .three: "3"
        case .four: "4"
        case .five: "5"
        case .six: "6"
        case .seven: "7"
        case .eight: "8"
        case .nine: "9"
        case .ten: "10"
        case .jack: "J"
        case .queen: "Q"
        case .king: "K"
        }
    }
}

extension Card.Suite: CustomStringConvertible {
    var description: String {
        return switch self {
        case .heart: "♥️"
        case .diamond: "♦️"
        case .spade: "♠️"
        case .club: "♣️"
        }
    }
}

//
//  Round+DataGeneration.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import Foundation

extension Round {
    static func generateWithPlayers(using parentRandom: inout some RandomNumberGenerator, game: Game, index: Int) -> Round {
        var random = SeededRandomGenerator(seed: Int.random(in: 0..<10000, using: &parentRandom))

        let entries = game.players.map { player in
            let cardCount = 0..<Int.random(in: 0..<5, using: &random)
            
            let cards = cardCount.map { _ in
                Card(rank: Card.Rank.allCases.randomElement(using: &random)!, suite: Card.Suite.allCases.randomElement(using: &random)!)
            }
            return (player.name, cards)
        }

        return Round(game: game, scores: .init(uniqueKeysWithValues: entries), index: index)
    }
}


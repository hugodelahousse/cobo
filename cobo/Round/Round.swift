//
//  Round.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftData

@Model
final class Round: CustomStringConvertible {
    var game: Game

    var index: Int

    var scores: [String: [Card]]

    init(game: Game, scores: [String: [Card]], index: Int) {
        self.game = game
        self.scores = scores
        self.index = index
    }

    func playerScore(player: Player, blackKingValue: Int) -> Int {
        let cards = self.scores[player.name] ?? []
        let score = cards.reduce(0) { score, card in
            score + card.value(blackKingValue: blackKingValue)
        }

        return score
    }
    
    var description: String {
        "Round(\(scores))"
    }
}

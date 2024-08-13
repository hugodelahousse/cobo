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
    var coboCaller: String? = nil
    var index: Int

    private var scores: [String: [Card]]

    init(game: Game, scores: [String: [Card]], index: Int) {
        self.game = game
        self.scores = scores
        self.index = index
        game.computePlayerScores()
    }
    
    func setPlayerCards(player: Player, cards: [Card], calledCobo: Bool = false) {
        scores[player.name] = cards
        
        if calledCobo {
            self.coboCaller = player.name
        }
        
        game.computePlayerScores()
    }
    
    func cards(for player: Player) -> [Card] {
        return scores[player.name] ?? []
    }

    var description: String {
        "Round(\(scores))"
    }
}

//
//  Game.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import Fakery

struct Game: Codable, Identifiable, Hashable {    
    var id = UUID()
    var date: Date
    // var players: [Player]
    var rounds: [Round]
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var highScore: Int {
        get {
            guard let loser = self.loser else {
                return 0
            }
            return self.playerScore(player: loser)
        }
    }
    
    var loser: Player? {
         nil
//        return players.max { a, b in
//            self.playerScore(player: a) > self.playerScore(player: b)
//        }
    }
    
    var winner: Player? {
        nil
//        return players.min { a, b in
//            self.playerScore(player: a) > self.playerScore(player: b)
//        }
    }
    
    func playerScore(player: Player) -> Int {
        return rounds.reduce(0) { currentScore, round in
            return currentScore + (round.scores[player.name]?.reduce(0) { currentRoundScore, card in
                card.value(blackKingValue: currentScore)
            } ?? 0)
        }
    }
}

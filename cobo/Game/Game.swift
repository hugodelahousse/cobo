//
//  Game.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftData

@Model
final class Game {
    var date: Date
    
    var players: [Player] = []

    var rounds: [Round] = []
    
    var sortedRounds: [Round] {
        rounds.sorted {
            $0.index < $1.index
        }
    }
    
    init(date: Date) {
        self.date = date
    }

    var highScore: Int {
        guard let loser = loser else {
            return 0
        }
        return playerScore(player: loser)
    }
    
    var loser: Player? {
        return players.max { a, b in
            self.playerScore(player: a) < self.playerScore(player: b)
        }
    }
    
    var winner: Player? {
        return players.min { a, b in
            self.playerScore(player: a) < self.playerScore(player: b)
        }
    }
    
    func blackKingValue(player: Player, atRound round: Round) -> Int {
        guard let previousRound = self.sortedRounds.first(where: { $0.index == round.index - 1 }) else {
            return 0
        }
        return self.playerScore(player: player, atRound: previousRound)
    }
    

    func playerScore(player: Player, forRound round: Round) -> Int {
        return round.playerScore(player: player, blackKingValue: self.blackKingValue(player: player, atRound: round))
    }
    
    func playerScore(player: Player, atRound round: Round) -> Int {
        var score = 0

        for round in sortedRounds.filter({ $0.index <= round.index }) {
            let blackKingValue = score
            score += round.playerScore(player: player, blackKingValue: blackKingValue)
        }
        
        return score
    }
    
    func playerScore(player: Player) -> Int {
        guard let lastRound = sortedRounds.last else {
            return 0
        }
        
        return playerScore(player: player, atRound: lastRound)
    }
}

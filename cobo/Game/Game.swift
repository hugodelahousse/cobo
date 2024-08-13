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
        computePlayerScores()
    }

    var highScore: Int {
        return totalPlayerScores.max {
            a, b in a.value < b.value
        }?.value ?? 0
    }
    
    var loser: Player? {
        let winnerName = totalPlayerScores.max {
            a, b in a.value < b.value
        }?.key

        return players.first { $0.name == winnerName }
    }
    
    var winner: Player? {
        let winnerName = totalPlayerScores.min {
            a, b in a.value < b.value
        }?.key

        return players.first { $0.name == winnerName }
    }
    
    @Attribute(.ephemeral) private var totalPlayerScores: [String: Int] = [:]
    @Attribute(.ephemeral) private var roundPlayerScores: [Int: [String: Int]] = [:]
    
    var scoreboard: [(player: Player, score: Int)] {
        totalPlayerScores
            .sorted { $0.value < $1.value }
            .map { name, score in (players.first { player in player.name == name }!, score) }
    }
    
    func playerScore(player: Player) -> Int {
        print("playerScore \(player)")
        return totalPlayerScores[player.name] ?? 0
    }
    
    func playerScore(player: Player, round: Round) -> Int {
        return roundPlayerScores[round.index]?[player.name] ?? 0
    }
    
    func computePlayerScores() {
        var currentScores: [String: Int] = [:]
        
        for round in sortedRounds {
            var roundScores: [String: Int] = [:]
            
            for player in players {
                var score = 0
                for card in round.cards(for: player) {
                    score += card.value(blackKingValue: currentScores[player.name] ?? 0)
                }
                roundScores[player.name] = score
            }
                        
            if let coboCaller = players.first(where: { $0.name == round.coboCaller }),
               let coboCallerScore = roundScores[coboCaller.name],
               let minNonCoboScore = roundScores.filter({ $0.key != round.coboCaller }).values.min()
            {
                if coboCallerScore < minNonCoboScore {
                    roundScores[coboCaller.name] = 0
                } else if coboCallerScore > minNonCoboScore {
                    roundScores[coboCaller.name] = coboCallerScore * 2
                }
            }
            
            roundPlayerScores[round.index] = roundScores
            for player in players {
                currentScores[player.name] = (currentScores[player.name] ?? 0) + (roundScores[player.name] ?? 0)
            }
        }
        
        totalPlayerScores = currentScores
    }
}

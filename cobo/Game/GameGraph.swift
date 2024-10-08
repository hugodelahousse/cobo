//
//  GameGraph.swift
//  cobo
//
//  Created by Hugo Delahousse on 31/07/2024.
//

import Charts
import Foundation
import SwiftUI

struct PlayerScoreForRound: Identifiable {
    var id: String {
        return "\(player.name) round: \(round)"
    }

    var player: Player
    var round: Int
    var score: Int
}

struct GameGraph: View {
    var game: Game

    var data: [PlayerScoreForRound] {
        game.sortedRounds.flatMap { round in
            game.players.map { player in
                PlayerScoreForRound(player: player, round: round.index, score: game.playerScore(player: player, round: round))
            }
        }
    }
    
    var maxYScale: Int {
        if let maxScore = data.map(\.score).max() {
            return maxScore + 10
        }
        
        return 10
    }
    
    var maxXScale: Int {
        if let maxRound = game.rounds.map(\.index).max() {
            return maxRound + 1
        }
        return 2
    }

    var body: some View {
        return Chart(data) { scoreForRound in
            BarMark(
                x: .value("Round", scoreForRound.player.name),
                y: .value("Score", scoreForRound.score)
            ).foregroundStyle(by: .value("Round", "\(scoreForRound.round + 1)"))
        }
    }
}

#Preview {
    ModelPreview { game in
        GameGraph(game: game)
    }
}

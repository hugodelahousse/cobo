//
//  Game+DataGeneration.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import Foundation
import SwiftData

extension Game {
    static func generateAll(modelContext: ModelContext) {
        var random = SeededRandomGenerator(seed: 1)
        
        let allPlayers = try! modelContext.fetch(FetchDescriptor<Player>(sortBy: [.init(\.name)]))
        
        do {
            let game = Game(
                date: Date(timeIntervalSinceNow: -5)
            )
            modelContext.insert(game)
            game.players = [allPlayers[0], allPlayers[1], allPlayers[2]]
            
            for index in 0..<3 {
                let round = Round.generateWithPlayers(using: &random, game: game, index: index)
                modelContext.insert(round)
                game.rounds.append(round)
            }
        }
//        
//        do {
//            let game = Game(
//                date: Date(timeIntervalSinceNow: -10)
//            )
//            modelContext.insert(game)
//            game.players = [allPlayers[1], allPlayers[3], allPlayers[4]]
//            for index in 0..<4 {
//                let round = Round.generateWithPlayers(using: &random, game: game, index: index)
//                modelContext.insert(round)
//            }
//        }
//        
//        do {
//            let game = Game(
//                date: Date(timeIntervalSinceNow: -15)
//            )
//            modelContext.insert(game)
//            game.players = allPlayers
//            for index in 0..<7 {
//                let round = Round.generateWithPlayers(using: &random, game: game, index: index)
//                modelContext.insert(round)
//            }
//        }
    }
}

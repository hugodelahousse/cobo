//
//  GameScores.swift
//  cobo
//
//  Created by Hugo Delahousse on 07/08/2024.
//

import SwiftUI

struct GameScores: View {
    var game: Game

    let rows = [
        GridItem(.adaptive(minimum: 100)),
    ]

    var body: some View {
        print(game.rounds)

        return VStack {
            Spacer()
            GameGraph(game: game).frame(height: 300)
            Spacer()
            LazyVGrid(columns: rows, alignment: .center, spacing: 40) {
                ForEach(game.players) { player in
                    let allCards = game.sortedRounds.flatMap { round in round.cards(for: player) }

                    VStack(spacing: 20) {
                        CardStack(cards: allCards) { card in CardLabel(card: card).frame(width: 50) }
                        Text("\(player.name)")
                    }
                }.frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    ModelPreview { game in
        GameScores(game: game)
    }
}

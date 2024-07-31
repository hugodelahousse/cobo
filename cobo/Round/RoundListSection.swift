//
//  RoundListSection.swift
//  cobo
//
//  Created by Hugo Delahousse on 19/07/2024.
//

import SwiftUI

struct RoundListSection: View {
    var round: Round
    
    var body: some View {
        Section {
            ForEach(round.game.players) { player in
                NavigationLink {
                    CardsEditor(cards: round.scores[player.name] ?? [], save: { cards in
                        round.scores[player.name] = cards
                    })
                } label: {
                    HStack(spacing: 10) {
                        Text(player.name)
                        Spacer()
                        Text("\(round.game.playerScore(player: player, forRound: round))")
                    }
                }
            }
        } header: {
            Text("Round \(round.index + 1)")
        }
    }
}

#Preview {
    ModelPreview {round in
        List {
            RoundListSection(round: round).coboDataContainer()
        }
    }
}

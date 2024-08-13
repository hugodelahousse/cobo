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
                    CardsEditor(cards: round.cards(for: player), coboCalled: round.coboCaller == player.name, save: { cards, calledCobo in
                        
                        round.setPlayerCards(player: player, cards: cards, calledCobo: calledCobo)
                    }).navigationTitle("\(player.name)")
                } label: {
                    HStack(spacing: 10) {
                        Text(player.name)
                        if round.coboCaller == player.name {
                            Image(systemName: "person.bust")
                        }
                        Spacer()
                        Text("\(round.game.playerScore(player: player, round: round))")
                    }
                }
            }
        } header: {
            Text("Round \(round.index + 1)")
        }
    }
}

#Preview {
    ModelPreview { round in
        NavigationStack {
            List {
                RoundListSection(round: round).coboDataContainer()
            }
        }
    }
}

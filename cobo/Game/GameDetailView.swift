//
//  GameDetailView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftData
import SwiftUI

struct GameDetailView: View {
    @Environment(\.modelContext) var modelContext
    var game: Game    

    var body: some View {
        print(Self._printChanges())
        let scoreboard = game.scoreboard
        return NavigationStack {
            List {
                Section {
                    NavigationLink {
                        GameScores(game: game)
                    } label: {
                        GameGraph(game: game).frame(height: 200)
                    }
                    HStack {
                        Spacer()
                        Text("🙂‍↔️ \(game.loser?.name ?? "??") 🙂‍↔️").font(.largeTitle)
                        Spacer()
                    }
                }

                ForEach(scoreboard, id: \.player) { (player, score) in
                    HStack(spacing: 10) {
                        AvatarView(size: 40, player: player)
                        Text(player.name)
                        Spacer()
                        Text("\(score)")
                    }
                }

                ForEach(game.sortedRounds) { round in
                    RoundListSection(round: round)
                }

                Section {
                    Button("Add round") {
                        withAnimation {
                            let round = Round(
                                game: game,
                                scores: [:],
                                index: game.rounds.count
                            )
                            game.rounds.append(round)
                        }
                    }
                }
            }

            .navigationTitle("\(game.date.formatted(date: .long, time: .omitted))")
        }
    }
}

#Preview {
    ModelPreview { game in
        GameDetailView(game: game)
    }
}

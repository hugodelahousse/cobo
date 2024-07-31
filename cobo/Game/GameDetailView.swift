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

    @Query private var rounds: [Round]

    init(game: Game) {
        self.game = game
        let id = game.persistentModelID
        let predicate = #Predicate<Round> { $0.game.persistentModelID == id }
        _rounds = Query(filter: predicate, sort: \.index)
    }

    var body: some View {
        return NavigationStack {
            List {
                Section {
                    GameGraph(game: game).frame(height: 200)
                    HStack {
                        Spacer()
                        Text("🙂‍↔️ \(game.loser?.name ?? "??") 🙂‍↔️").font(.largeTitle)
                        Spacer()
                    }
                }

                ForEach(game.players) { player in
                    HStack(spacing: 10) {
                        AvatarView(size: 40, player: player)
                        Text(player.name)
                        Spacer()
                        Text("\(game.playerScore(player: player))")
                    }
                }

                ForEach(rounds) { round in
                    RoundListSection(round: round)
                }

                Section {
                    Button("Add round") {
                        withAnimation {
                            let round = Round(
                                game: game,
                                scores: [:],
                                index: rounds.count
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

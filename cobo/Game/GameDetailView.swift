//
//  GameDetailView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftUI
import Fakery

class GameSettings: ObservableObject {
    @Published var players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
}

struct GameDetailView: View {
    @EnvironmentObject var settings: GameSettings
    @State private var showAddPlayerSheet = false
    
    let game: Game
    var body: some View {
        NavigationStack {
            VStack {
                Text("🙂‍↔️ \(game.loser?.name ?? "??") 🙂‍↔️").font(.largeTitle).padding()
                
                List {
//                    ForEach(game.players) { player in
//                        HStack(spacing: 10) {
//                            AvatarView(size: 40, player: player)
//                            Text(player.name)
//                            Spacer()
//                            Text("\(game.playerScore(player: player))")
//                        }
//                    }

                    ForEach(0..<game.rounds.count, id: \.self) { index in
                        RoundSectionView(round: game.rounds[index], index: index)
                    }
                }
            }
            .navigationTitle("\(game.date.formatted(date: .long, time: .omitted))")
        }
    }
}

struct RoundSectionView: View {
    let round: Round
    let index: Int
    
    
    var body: some View {
        Section {
            ForEach(round.scores.sorted { $0.0 < $1.0 }, id: \.key) { (playerName, cards) in
                HStack(spacing: 10) {
                    Text(playerName)
                    Spacer()
                    ForEach(0..<cards.count, id: \.self) { index in
                        Text("\(cards[index])").font(.system(size: 50))
                    }
                }.frame(minHeight: 50)
            }
        } header: {
            Text("Round \(index + 1)")
        }
    }
}

#Preview {
    let settings = GameSettings(players: coboFaker.array(min: 20, max: 30, {
        coboFaker.player()
    }))
    return GameDetailView(game: coboFaker.game()).environmentObject(settings)
}

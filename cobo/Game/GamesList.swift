//
//  GamesView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftData
import SwiftUI

struct GamesView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path: [String] = []
    @Query(sort: [SortDescriptor(\Game.date, order: .reverse)]) var games: [Game]

    func deleteGame(_ game: Game) {
        withAnimation {
            modelContext.delete(game)
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    Section {
                        NavigationLink {
                            GameDetailView(game: game)
                        } label: {
                            GameCardView(game: game)
                        }
                        #if os(iOS)
                        .swipeActions(edge: .trailing) {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                deleteGame(game)
                            }
                        }
                        #else
                        .contextMenu {
                            Button("Delete game") {
                                deleteGame(game)
                            }
                        }
                        #endif
                    } header: {
                        Text("\(game.date.formatted(date: .long, time: .omitted))")
                    }
                }
            }.toolbar {
                ToolbarItem(placement: .primaryAction) {
                    NavigationLink {
                        GameEditor()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .navigationTitle("Games").onAppear {
                for game in games {
                    game.computePlayerScores()
                }
            }
        }
    }
}

#Preview {
    GamesView().coboDataContainer()
}

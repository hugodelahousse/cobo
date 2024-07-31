//
//  GamesView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftData
import SwiftUI

enum Destination {
    case createGame
}

struct GamesView: View {
    @Environment(\.modelContext) var modelContext
    @State private var path: [String] = []
    @Query(sort: [SortDescriptor(\Game.date, order: .reverse)]) var games: [Game]

    var body: some View {
        NavigationStack {
            List {
                ForEach(games) { game in
                    Section {
                        NavigationLink {
                            GameDetailView(game: game)
                        } label: {
                            GameCardView(game: game)
                        }.swipeActions(edge: .trailing) {
                            Button("Delete", systemImage: "trash", role: .destructive) {
                                modelContext.delete(game)
                                
                            }
                        }
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
            .navigationTitle("Games")
        }
    }
}

#Preview {
    GamesView().coboDataContainer()
}

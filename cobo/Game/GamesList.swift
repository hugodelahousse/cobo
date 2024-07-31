//
//  GamesView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftUI
import Fakery

enum Destination {
    case createGame
}

struct GamesView: View {
    @State private var path: [Destination] = []

    let games: [Game]
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(games) { game in
                    NavigationLink {
                        GameDetailView(game: game)
                    } label: {
                        GameCardView(game: game)
                    }
                }
            }.toolbar {
                ToolbarItem {
                    NavigationLink("\(Image(systemName: "plus"))", value: Destination.createGame)
                }
            }
            .navigationDestination(for: Destination.self) { destination in
                Text("Hello, world")
            }
            .navigationTitle("Games")
        }
    }
}

#Preview {
     GamesView(games: Faker().array(min: 3, max: 5) { Faker().game() })
}

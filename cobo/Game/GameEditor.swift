//
//  GameEditor.swift
//  cobo
//
//  Created by Hugo Delahousse on 19/07/2024.
//

import SwiftData
import SwiftUI

struct GameEditor: View {
    @Environment(\.modelContext) var modelContext;
    @Environment(\.dismiss) var dismiss;
    @State var selectedPlayerNames = Set<String>()

    var body: some View {
        PlayerSelectionList(selection: $selectedPlayerNames)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let descriptor = FetchDescriptor<Player>(
                            predicate: #Predicate { selectedPlayerNames.contains($0.name) }
                        )

                        do {
                            let players = try modelContext.fetch(descriptor)

                            let game = Game(date: Date.now)
                            modelContext.insert(game)
                            game.players = players
                        } catch {
                            print("\(error)")
                        }
                        
                        dismiss()
                    }
                }
            }.navigationTitle(Text("New game"))
    }
}

#Preview {
    GameEditor().coboDataContainer()
}

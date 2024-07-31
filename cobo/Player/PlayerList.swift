//
//  PlayersView.swift
//  cobo
//
//  Created by Hugo Delahousse on 31/07/2024.
//

import SwiftUI
import SwiftData

struct PlayerList: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [SortDescriptor(\Player.name, order: .reverse)]) var players: [Player]
    
    var body: some View {
        NavigationStack {
            List(players) { player in
                NavigationLink {
                    PlayerEditor(player: player)
                } label: {
                    HStack(spacing: 8) {
                        AvatarView(size: 40, player: player)
                        Text(player.name)
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerList().coboDataContainer()
}

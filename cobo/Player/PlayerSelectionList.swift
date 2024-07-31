//
//  PlayerSelectionList.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import Foundation
import SwiftData
import SwiftUI

extension Set {
    mutating func toggle(_ member: Element) {
        if self.contains(member) {
            self.remove(member)
        } else {
            self.insert(member)
        }
    }
}

struct PlayerSelectionList: View {
    @Query(sort: \Player.name) private var players: [Player]

    @Binding var selection: Set<String>
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(self.players, id: \.name) { player in
                        let isSelected = self.selection.contains(player.name)
                        
                        Button(action: { withAnimation(.interactiveSpring) { self.selection.toggle(player.name) } }) {
                            HStack {
                                Image(systemName: isSelected ? "checkmark.circle" : "circle").renderingMode(.original).foregroundStyle(.tertiary).imageScale(.large)
                                Text("\(player.name)")
                            }
                        }.foregroundStyle(.primary)
                    }
                    
                    NavigationLink {
                        PlayerEditor(player: nil)
                    } label: {
                        Text("Add player").foregroundStyle(.tint)
                    }
                } header: {
                    Text("Players")
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @State var selection = Set<String>()
        var body: some View {
            return PlayerSelectionList(selection: $selection)
        }
    }
    return Preview().coboDataContainer()
}

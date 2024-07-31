//
//  PlayerEditor.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import SwiftUI

struct PlayerEditor: View {
    enum FocusedField {
        case name
    }
    @FocusState private var focusedField: FocusedField?
        
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    let player: Player?
    
    @State private var name = ""
    
    private func save() {
        if let player {
            player.name = name
        } else {
            let newPlayer = Player(name: name)
            modelContext.insert(newPlayer)
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                
                Section(header: Text("Player")) {
                    TextField("Name", text: $name, prompt: Text("Name")).focused($focusedField, equals: .name)
                }
            }.defaultFocus($focusedField, .name).onAppear {
                focusedField = .name
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                }
            }
        }
        .onAppear {
            if let player {
                name = player.name
            }
        }
    }
}

#Preview {
    PlayerEditor(player: nil)
}

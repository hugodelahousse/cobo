//
//  PlayerEditor.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import SwiftUI

struct PlayerEditor: View {
    let player: Player?
    
    @State private var name = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $name, prompt: Text("Player name"))
        }.onAppear {
            if let player {
                name = player.name
            }
        }
    }
    
}

#Preview {
    PlayerEditor(player: nil)
}

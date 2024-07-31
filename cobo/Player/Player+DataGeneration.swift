//
//  Player+DataGeneration.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import Foundation
import SwiftData

extension Player {
    static func generateAll(modelContext: ModelContext) {
        modelContext.insert(Player(name: "Gougou"))
        modelContext.insert(Player(name: "Manou"))
        modelContext.insert(Player(name: "Mathou"))
        modelContext.insert(Player(name: "Kekou"))
        modelContext.insert(Player(name: "Roro"))
    }
}

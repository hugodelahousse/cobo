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
        let names = ["Hugo", "Sarah", "Manne", "Kellian", "Mathieu", "Rodrigue", "Claire"]
        for name in names {
            let existingPlayer = try? modelContext.fetch(.init(predicate: #Predicate<Player> {$0.name == name})).first
            if existingPlayer == nil {
                modelContext.insert(Player(name: name))
            }
        }
    }
}

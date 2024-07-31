//
//  DataGeneration.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import Foundation
import OSLog
import SwiftData

private let logger = Logger(subsystem: "CoboData", category: "DataGeneration")

@Model public class DataGeneration {
    init() {}

    private func generateInitialData(modelContext: ModelContext) {
        Player.generateAll(modelContext: modelContext)
        Game.generateAll(modelContext: modelContext)
    }

    private static func instance(with modelContext: ModelContext) -> DataGeneration {
        if let result = try! modelContext.fetch(FetchDescriptor<DataGeneration>()).first {
            return result
        } else {
            let instance = DataGeneration()
            modelContext.insert(instance)
            return instance
        }
    }

    public static func generateAllData(modelContext: ModelContext) {
        instance(with: modelContext).generateInitialData(modelContext: modelContext)
    }
}

public extension DataGeneration {
    static let container = try! ModelContainer(for: schema, configurations: [.init(isStoredInMemoryOnly: DataGenerationOptions.inMemoryPersistence)])

    static let schema = SwiftData.Schema([
        DataGeneration.self,
        Player.self,
        Round.self,
        Game.self
    ])
}

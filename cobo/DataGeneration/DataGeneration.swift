//
//  DataGeneration.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import Foundation
import SwiftData
import OSLog

private let logger = Logger(subsystem: "CoboData", category: "DataGeneration")

@Model public class DataGeneration {
    init() {}
    
    private func generateInitialData(modelContext: ModelContext) {
        Player.generateAll(modelContext: modelContext)
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
        let instance = instance(with: modelContext)
    }
}

public extension DataGeneration {
    static let container = try! ModelContainer(for: schema, configurations: [.init(isStoredInMemoryOnly: DataGenerationOptions.inMemoryPersistence)])
    
    static let schema = SwiftData.Schema([
        DataGeneration.self,
        Player.self
    ])
}

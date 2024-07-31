//
//  CoboDataContainer.swift
//  cobo
//
//  Created by Hugo Delahousse on 17/07/2024.
//

import Foundation
import SwiftData
import SwiftUI

struct CoboDataContainerViewModifier: ViewModifier {
    let container: ModelContainer

    init(inMemory: Bool) {
        container = try! ModelContainer(for: DataGeneration.schema, configurations: [ModelConfiguration(isStoredInMemoryOnly: inMemory)])
    }

    func body(content: Content) -> some View {
        content
            .generateData()
            .modelContainer(container)
    }
}

struct GenerateDataViewModifier: ViewModifier {
    @Environment(\.modelContext) private var modelContext

    func body(content: Content) -> some View {
        content.onAppear {
            if DataGenerationOptions.hasInitialData {
                DataGeneration.generateAllData(modelContext: modelContext)
            }
        }
    }
}

public extension View {
    func coboDataContainer(inMemory: Bool = DataGenerationOptions.inMemoryPersistence) -> some View {
        modifier(CoboDataContainerViewModifier(inMemory: inMemory))
    }
}

private extension View {
    func generateData() -> some View {
        modifier(GenerateDataViewModifier())
    }
}

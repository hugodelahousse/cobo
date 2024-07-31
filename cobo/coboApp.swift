//
//  coboApp.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftUI

@main
struct coboApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().coboDataContainer(inMemory: false)
        }
    }
}

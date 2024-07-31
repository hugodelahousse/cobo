//
//  ContentView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            GamesView().toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        PlayerList()
                    } label: {
                        Image(systemName: "person.2.circle")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView().coboDataContainer()
}

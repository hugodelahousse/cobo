//
//  GameCardView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftUI
import Fakery

struct GameCardView: View {
    let game: Game
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Text("\(game.date.formatted(date: .long, time: .omitted))").font(.title3)
                AvatarStackView(size: 25, players: [])
            }
            
            Spacer()
            
            VStack (alignment: .trailing) {
                Text("\(game.highScore)\(Image(systemName: "number"))")
                    .font(.largeTitle)
                Text("\(game.rounds.count) rounds").font(.caption)
            }
            
            
        }
        .padding(20)
        .cornerRadius(5.0)
    }
}

#Preview {
    GameCardView(game: Faker().game())
}

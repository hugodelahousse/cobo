//
//  GameCardView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftUI

struct GameCardView: View {
    let game: Game

    var body: some View {
        HStack(alignment: .center) {
                AvatarStackView(size: 30, players: game.players)

            Spacer()

            VStack(alignment: .trailing) {
                Text("\(game.highScore)")
                    .font(.largeTitle)
                Text("\(game.rounds.count) rounds").font(.caption)
            }
        }
    }
}

#Preview {
    ModelPreview { game in
        GameCardView(game: game)
    }
}

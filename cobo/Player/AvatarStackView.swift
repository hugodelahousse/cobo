//
//  AvatarStackView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftData
import SwiftUI

struct AvatarStackView: View {
    let size: CGFloat
    let players: [Player]

    var body: some View {
        HStack(spacing: -size / 4) {
            ForEach(players) { player in
                ZStack {
                    Circle()
                        .stroke(.white, lineWidth: 1)
                        .frame(width: size + 1, height: size + 1)

                    AvatarView(size: size, player: player)
                }
            }
        }
    }
}

#Preview {
    struct Preview: View {
        @Query var players: [Player]
        var body: some View {
            AvatarStackView(size: 50, players: players)
        }
    }
    
    return Preview().coboDataContainer()
}

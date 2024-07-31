//
//  AvatarView.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftUI

struct AvatarView: View {
    let size: CGFloat
    let player: Player

    var body: some View {
        ZStack {
            Circle().fill(Color.gray)

            Text(player.name.initials())
                .font(.system(size: 500))
                .minimumScaleFactor(0.01)
                .padding(size * 0.12)
                .foregroundStyle(.white)

        }.frame(width: size, height: size)
    }
}

#Preview {
    ModelPreview { player in
        AvatarView(size: 50, player: player)
    }
}

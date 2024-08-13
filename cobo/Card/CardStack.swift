//
//  CardStack.swift
//  cobo
//
//  Created by Hugo Delahousse on 06/08/2024.
//

import SwiftUI

struct CardStack<Content>: View where
    Content: View
{
    let cards: [Card]
    @ViewBuilder let contentBuilder: (Card) -> Content
    
    @State private var interactable: Bool = false

    var body: some View {
        let offsetMultiplier: Double = interactable ? 30 : 1
        return ZStack {
            ForEach(Array(cards.enumerated()), id: \.element) { index, card in
                let degree = Double(index) - Double(cards.count - 1) / 2

                contentBuilder(card)
                    .rotationEffect(.degrees(degree * 10), anchor: .bottom)
                    .offset(x: degree * offsetMultiplier)
            }
        }
    }

    func interactable(_ value: Bool = true) -> CardStack {
        var view = self
        view._interactable = State(initialValue: value)
        return view
    }
}

#Preview {
    CardStack(cards: [
        Card(rank: .ace, suite: .heart),
        Card(rank: .two, suite: .spade),
        Card(rank: .six, suite: .diamond),
        Card(rank: .king, suite: .spade),
        Card(rank: .king, suite: .club),
        Card(rank: .king, suite: .heart),
    ]) {
        CardLabel(card: $0).frame(width: 100)
    }
}

#Preview("interactable") {
    CardStack(cards: [
        Card(rank: .ace, suite: .heart),
        Card(rank: .two, suite: .spade),
        Card(rank: .six, suite: .diamond),
        Card(rank: .king, suite: .spade),
        Card(rank: .king, suite: .club),
        Card(rank: .king, suite: .heart),
    ]) {
        CardLabel(card: $0).frame(width: 100)
    }.interactable()
}

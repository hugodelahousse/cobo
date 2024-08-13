//
//  CardLabel.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import SwiftUI

extension Card.Suite {
    var filePrefix: String {
        return switch self {
        case .heart: "H"
        case .spade: "S"
        case .diamond: "D"
        case .club: "C"
        }
    }
}

struct CardLabel: View {
    let card: Card

    init(card: Card) {
        self.card = card
    }

    var body: some View {
        let text = switch card.rank {
        case .ace: Image("A\(card.suite.filePrefix)")
        case .two: Image("2\(card.suite.filePrefix)")
        case .three: Image("3\(card.suite.filePrefix)")
        case .four: Image("4\(card.suite.filePrefix)")
        case .five: Image("5\(card.suite.filePrefix)")
        case .six: Image("6\(card.suite.filePrefix)")
        case .seven: Image("7\(card.suite.filePrefix)")
        case .eight: Image("8\(card.suite.filePrefix)")
        case .nine: Image("9\(card.suite.filePrefix)")
        case .ten: Image("10\(card.suite.filePrefix)")
        case .jack: Image("J\(card.suite.filePrefix)")
        case .queen: Image("Q\(card.suite.filePrefix)")
        case .king: Image("K\(card.suite.filePrefix)")
        }

        return text.resizable().aspectRatio(contentMode: .fit)
    }
}

#Preview("All") {
    ScrollView {
        ForEach(Card.Suite.allCases, id: \.self) { suite in
            ForEach(Card.Rank.allCases, id: \.self) { rank in
                CardLabel(card: Card(rank: rank, suite: suite)).padding(30)
            }
        }
    }
}

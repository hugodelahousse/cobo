//
//  CardLabel.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import SwiftUI

struct CardLabel: View {
    let card: Card

    var body: some View {
        let text = switch card {
        case .ace: Image("AH")
        case .two: Image("2H")
        case .three: Image("3H")
        case .four: Image("4H")
        case .five: Image("5H")
        case .six: Image("6H")
        case .seven: Image("7H")
        case .eight: Image("8H")
        case .nine: Image("9H")
        case .ten: Image("10H")
        case .jack: Image("JH")
        case .queen: Image("QH")
        case .king(.red): Image("KH")
        case .king(.black): Image("KS")
        }
        
        return text.resizable().aspectRatio(contentMode: .fit)
    }
}

#Preview("All") {
    ScrollView {
        ForEach(Card.all, id: \.self) { card in
            CardLabel(card: card).frame(width: .infinity).padding(30)
        }
    }
    
}

#Preview("Red king") {
    CardLabel(card: .king(color: .red))
}

#Preview("Black king") {
    CardLabel(card: .king(color: .black))
}

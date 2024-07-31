//
//  CardsEditor.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .font(.system(size: 25))
            .background(.background.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}



struct CardsEditor: View {
    struct SelectedCard: Identifiable, Hashable {
        var id = UUID()
        var card: Card
    }
    
    @State var selectedCards: [SelectedCard]
    @Environment(\.dismiss) var dismiss
    var save: (_ cards: [Card]) -> Void
    
    init(cards: [Card], save: @escaping (_ cards: [Card]) -> Void) {
        selectedCards = cards.map { SelectedCard(card: $0) }
        self.save = save
    }


    func cardButton(_ text: String, card: Card) -> some View {
        Button { addCard(card) } label: {
            Text(text)
                .frame(width: 80, height: 80)
        }
        .buttonStyle(CustomButtonStyle())
    }

    func kingButton(_ text: String, color: CardColor) -> some View {
        Button { withAnimation { addCard(.king(color: color)) } } label: {
            Text(text)
                .frame(width: 170, height: 80)
        }.buttonStyle(CustomButtonStyle())
    }
    
    var selectedCardsContent: some View {
        ZStack {
            ForEach(Array(selectedCards.enumerated()), id: \.1) { index, card in
                let degree = Double(index) - Double(selectedCards.count - 1) / 2

                return Button {
                    removeCard(card)
                } label: {
                    CardLabel(card: card.card).frame(width: 100)
                }.rotationEffect(.degrees(degree * 10), anchor: .bottom)
                    .offset(x: degree * 30)
            }.transition(.move(edge: .top).combined(with: .opacity))
        }
    }

    func addCard(_ card: Card) {
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0.2)) {
            selectedCards.append(SelectedCard(card: card))
        }
    }
    
    func removeCard(_ card: SelectedCard) {
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0.1)) {
            selectedCards.removeAll { $0.id == card.id }
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            selectedCardsContent
            Spacer()
            HStack(alignment: .center) {
                cardButton("Ace", card: .ace)
                cardButton("2", card: .two)
                cardButton("3", card: .three)
                cardButton("4", card: .four)
            }
            HStack {
                cardButton("5", card: .five)
                cardButton("6", card: .six)
                cardButton("7", card: .seven)
                cardButton("8", card: .eight)
            }
            HStack {
                cardButton("9", card: .nine)
                cardButton("10", card: .ten)
                cardButton("J", card: .jack)
                cardButton("Q", card: .queen)
            }

            HStack {
                kingButton("Black K", color: .black)
                kingButton("Red K", color: .red)
            }
        }.toolbar {
            ToolbarItem {
                Button("Save") {
                    save(selectedCards.map(\.card))
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    return CardsEditor(cards: [.ace, .king(color: .black), .king(color: .red)], save: { cards in print(cards) })
}

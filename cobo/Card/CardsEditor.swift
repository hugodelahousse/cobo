//
//  CardsEditor.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import SwiftUI

struct ToggleButtonStyle: ButtonStyle {
    @Binding var selected: Bool

    init(selected: Binding<Bool> = .constant(false)) {
        _selected = selected
    }

    func makeBody(configuration: Configuration) -> some View {
        let label = configuration.label.font(.system(size: 25))

        let coloredLabel = selected ? AnyView(label.background(.tint)) : AnyView(label.background(.background.secondary))

        return coloredLabel.clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
    }
}

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        return configuration.label
            .font(.system(size: 25))
            .background(.background.secondary)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .opacity(configuration.isPressed ? 0.9 : 1)
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
        #if os(tvOS)
            .hoverEffect(.highlight)
        #endif
    }
}

struct CardsEditor: View {
    @State var selectedCards: [Card]
    @State var coboCalled: Bool = false

    @Environment(\.dismiss) var dismiss
    var save: (_ cards: [Card], _ cobo: Bool) -> Void

    init(cards: [Card], coboCalled: Bool, save: @escaping (_ cards: [Card], _ cobo: Bool) -> Void) {
        selectedCards = cards
        self.coboCalled = coboCalled
        self.save = save
    }

    func makeCard(rank: Card.Rank, black: Bool? = nil) -> Card {
        let validSuites: [Card.Suite] = switch black {
        case nil: [.heart, .spade, .diamond, .club]
        case .some(true): [.spade, .club]
        case .some(false): [.heart, .diamond]
        }

        let usedSuites: [Card.Suite: Int] = Dictionary(uniqueKeysWithValues: validSuites.map { suite in (suite, selectedCards.filter { $0.rank == rank && $0.suite == suite }.count) })

        if let suite = usedSuites.min(by: { a, b in a.value < b.value })?.key {
            return Card(rank: rank, suite: suite)
        }

        return Card(rank: rank, suite: validSuites.randomElement()!)
    }

    func addCard(rank: Card.Rank, black: Bool? = nil) {
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0.2)) {
            selectedCards.append(makeCard(rank: rank, black: black))
        }
    }

    func removeCard(_ card: Card) {
        withAnimation(.bouncy(duration: 0.3, extraBounce: 0.1)) {
            selectedCards.removeAll { $0.id == card.id }
        }
    }

    func cardButton(_ text: String, rank: Card.Rank) -> some View {
        Button { addCard(rank: rank) } label: {
            Text(text).frame(width: 80, height: 80)
        }
        .buttonStyle(CustomButtonStyle())
    }

    func kingButton(_ text: String, black: Bool) -> some View {
        Button { withAnimation { addCard(rank: .king, black: black) } } label: {
            Text(text)
                .frame(width: 170, height: 80)
        }.buttonStyle(CustomButtonStyle())
    }

    var selectedCardsContent: some View {
        CardStack(cards: selectedCards) { card in
            Button {
                removeCard(card)
            } label: {
                CardLabel(card: card).frame(width: 100)
            }
            #if os(macOS)
            .buttonStyle(.plain)
            #endif
            #if os(tvOS)
            .buttonStyle(.card)
            .hoverEffect(.highlight)
            #endif
            .transition(.move(edge: .top).combined(with: .opacity))
        }.interactable()
    }

    var body: some View {
        VStack {
            Spacer()
            selectedCardsContent
            Spacer()

            HStack {
                Button { withAnimation { coboCalled.toggle() } } label: {
                    Text("Cobo").frame(maxWidth: .infinity).frame(height: 80)
                }.buttonStyle(ToggleButtonStyle(selected: $coboCalled))
            }.padding(.horizontal, 20)

            HStack {
                cardButton("1", rank: .ace)
                cardButton("2", rank: .two)
                cardButton("3", rank: .three)
                cardButton("4", rank: .four)
            }
            HStack {
                cardButton("5", rank: .five)
                cardButton("6", rank: .six)
                cardButton("7", rank: .seven)
                cardButton("8", rank: .eight)
            }
            HStack {
                cardButton("9", rank: .nine)
                cardButton("10", rank: .ten)
                cardButton("J", rank: .jack)
                cardButton("Q", rank: .queen)
            }

            HStack {
                kingButton("Black K", black: true)
                kingButton("Red K", black: false)
            }
        }.toolbar {
            ToolbarItem {
                Button("Save") {
                    save(selectedCards, coboCalled)
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    return CardsEditor(
        cards: [
            Card(rank: .ace, suite: .heart),
            Card(rank: .king, suite: .spade),
            Card(rank: .king, suite: .heart),
        ],
        coboCalled: false,
        save: { cards, coboCaller in print(cards, coboCaller) }
    )
}

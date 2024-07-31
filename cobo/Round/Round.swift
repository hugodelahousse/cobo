//
//  Round.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import SwiftData

@Model
struct Round {
    var scores: [String: [Card]]
    
    init(scores: [String : [Card]]) {
        self.scores = scores
    }
}

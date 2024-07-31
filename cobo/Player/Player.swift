//
//  Player.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftData
import SwiftUI

@Model
final class Player: CustomStringConvertible {
    @Attribute(.externalStorage)
    var imageData: Data?

    @Attribute(.unique) var name: String
    
    var games: [Game] = []

    init(name: String, imageData: Data? = nil) {
        self.name = name
        self.imageData = imageData
    }
    
    var description: String {
        return "Player(\"\(name)\")"
    }    
}

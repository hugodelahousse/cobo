//
//  Player.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation
import SwiftUI

struct Player: Codable, Identifiable, Equatable {
    var id = UUID()
    var name: String
    var picture: URL?
}

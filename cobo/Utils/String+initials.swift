//
//  String+initials.swift
//  cobo
//
//  Created by Hugo Delahousse on 13/07/2024.
//

import Foundation

extension String {
    func initials() -> String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: self) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

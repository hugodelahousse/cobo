//
//  SeededRandomGenerator.swift
//  cobo
//
//  Created by Hugo Delahousse on 18/07/2024.
//

import Foundation

public struct SeededRandomGenerator: RandomNumberGenerator {
    public init(seed: Int) {
        srand48(seed)
    }

    public func next() -> UInt64 {
        UInt64(drand48() * 0x1.0p64) ^ UInt64(drand48() * 0x1.0p16)
    }
}

//
//  Navigable.swift
//  iOSKMP
//
//  Created by Timea Varga on 26.04.2024.
//

import Foundation

protocol Navigable: Identifiable, Hashable {}

extension Navigable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

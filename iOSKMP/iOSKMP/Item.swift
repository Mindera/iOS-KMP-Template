//
//  Item.swift
//  iOSKMP
//
//  Created by Naveen Katari  on 18/03/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}

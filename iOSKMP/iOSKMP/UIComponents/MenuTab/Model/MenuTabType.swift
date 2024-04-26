//
//  MenuTab.swift
//  iOSKMP
//
//  Created by Timea Varga on 16.04.2024.
//

import SwiftUI

enum MenuTabType: String, CaseIterable {
    case home
    case settings
}

extension MenuTabType {
    var title: LocalizedStringKey {
        switch self {
        case .home:
            return "Currency exchange"
        case .settings:
            return "Settings"
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "arrowtriangle.up"
        case .settings:
            return "gearshape"
        }
    }
}

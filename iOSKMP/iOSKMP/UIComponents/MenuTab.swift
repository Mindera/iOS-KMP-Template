//
//  MenuTab.swift
//  iOSKMP
//
//  Created by Timea Varga on 16.04.2024.
//

import Foundation

enum MenuTab: String, CaseIterable {
    case home
    case CHFExchange
    case GBPExchange
    case settings
}

extension MenuTab {
    var title: String {
        switch self {
        case .home:
            return "Gold"
        case .CHFExchange:
            return "CHF exchange"
        case .GBPExchange:
            return "GBP exchange"
        case .settings:
            return rawValue.capitalized
        }
    }
    
    var imageName: String {
        switch self {
        case .home:
            return "circle.fill"
        case .CHFExchange, .GBPExchange:
            return "arrowtriangle.up"
        case .settings:
            return "gearshape"
        }
    }
}
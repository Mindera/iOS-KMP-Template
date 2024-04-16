//
//  CurrencyExchangeViewMode.swift
//  iOSKMP
//
//  Created by Timea Varga on 15.04.2024.
//

import Foundation

enum CurrencyExchangeViewMode: CaseIterable, Identifiable {
    case graph, list
    var id: Self { self }
}

extension CurrencyExchangeViewMode {
    var title: String {
        switch self {
        case .graph:
            return "Graph view"
        case .list:
            return "List view"
        }
    }
}

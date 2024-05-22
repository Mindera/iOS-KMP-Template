//
//  CurrencyExchangeRate.swift
//  iOSKMP
//
//  Created by timea.varga on 22.05.2024.
//

import Foundation

struct CurrencyExchangeRate: Hashable, Codable {
    let id: String
    let code: String
    let currencyName: String
    let exchangeRate: Double
}

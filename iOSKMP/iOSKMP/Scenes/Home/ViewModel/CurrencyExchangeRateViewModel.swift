//
//  CurrencyExchangeRate.swift
//  iOSKMP
//
//  Created by timea.varga on 14.05.2024.
//

import Foundation

struct CurrencyExchangeRateViewModel: Identifiable {
    let id: String
    let code: String
    let currencyName: String
    let exchangeRate: Double
}

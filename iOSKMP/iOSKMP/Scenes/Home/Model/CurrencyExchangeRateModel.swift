//
//  CurrencyExchangeRateModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 12.04.2024.
//

import Foundation

struct CurrencyExchangeRateModel: Identifiable {
    let code: String
    let currencyName: String
    let exchangeRate: Double
    let id = UUID()
}

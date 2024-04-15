//
//  CurrencyExchangeModel.swift
//  iOSKMP
//
//  Created by Timea Varga on 12.04.2024.
//

import Foundation

struct CurrencyExchangeModel: Identifiable {
    let date: String
    let exchangeRates: [CurrencyExchangeRateModel]
    let id = UUID()
}

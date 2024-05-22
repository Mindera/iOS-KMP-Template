//
//  CurrencyExchangeListViewModel.swift
//  iOSKMP
//
//  Created by timea.varga on 17.05.2024.
//

import Foundation

struct CurrencyExchangeListViewModel: Identifiable {
    let id: String
    let date: String
    let exchangeRates: [CurrencyExchangeRateViewModel]
}

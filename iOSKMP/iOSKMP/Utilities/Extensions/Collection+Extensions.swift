//
//  Collection+Extensions.swift
//  iOSKMP
//
//  Created by timea.varga on 22.05.2024.
//

import Foundation

extension Collection where Element == CurrencyExchange {
    func mapToCurrencyExchangeListViewModels() -> [CurrencyExchangeListViewModel] {
        map {
            CurrencyExchangeListViewModel(
                id: $0.id,
                date: $0.date,
                exchangeRates: $0.exchangeRates.mapToCurrencyExchangeRateViewModels()
            )
        }
    }
}

extension Collection where Element == CurrencyExchangeRate {
    func mapToCurrencyExchangeRateViewModels() -> [CurrencyExchangeRateViewModel] {
        map {
            CurrencyExchangeRateViewModel(
                id: $0.id,
                code: $0.code,
                currencyName: $0.currencyName,
                exchangeRate: $0.exchangeRate
            )
        }
    }
}

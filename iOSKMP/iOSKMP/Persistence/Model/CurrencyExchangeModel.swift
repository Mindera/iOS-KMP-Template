//
//  CurrencyExchangeModel.swift
//  iOSKMP
//
//  Created by timea.varga on 13.05.2024.
//

import SwiftData
import Foundation

@Model
final class CurrencyExchangeModel {
    @Attribute(.unique) var referenceId: String
    var date: String
    var exchangeRates: [CurrencyExchangeRate]
    var timestamp: Date
    
    init(referenceId: String, date: String, exchangeRates: [CurrencyExchangeRate], timestamp: Date = Date()) {
        self.referenceId = referenceId
        self.date = date
        self.exchangeRates = exchangeRates
        self.timestamp = timestamp
    }
}

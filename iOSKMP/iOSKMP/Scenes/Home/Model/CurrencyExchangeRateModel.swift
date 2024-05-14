//
//  CurrencyExchangeRateModel.swift
//  iOSKMP
//
//  Created by timea.varga on 13.05.2024.
//

import SwiftData
import Foundation

@Model
final class CurrencyExchangeRateModel {
    @Attribute(.unique) var referenceId: String
    var code: String
    var currencyName: String
    var exchangeRate: Double
    var timestamp: Date
    
    init(referenceId: String, code: String, currencyName: String, exchangeRate: Double, timestamp: Date = Date()) {
        self.referenceId = referenceId
        self.code = code
        self.currencyName = currencyName
        self.exchangeRate = exchangeRate
        self.timestamp = timestamp
    }
}
